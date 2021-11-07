extends KinematicBody2D

export var spd = 200 #скорость
export var drag = 0.8 #коэффициент трения


var velocity = Vector2(0,0) #вектор движения
var can_control = true #может ли игрок контроллировать персонажа
var input = Vector2(0,0) #то, куда игрок ХОЧЕТ пойти

var max_hp = 10
export var hp = 10
export var coins = 20

export(NodePath) var current_gun

func _ready():
	$Camera2D.limit_left = get_parent().bounding_box.position.x
	$Camera2D.limit_right = get_parent().bounding_box.end.x
	$Camera2D.limit_top = get_parent().bounding_box.position.y
	$Camera2D.limit_bottom = get_parent().bounding_box.end.y
	
	inventory_update()
	$GUI.hp_update()
	$GUI.coin_update()
	$GUI/dialogue.visible = false
	get_node(current_gun).visible = true
	
	#get_node("/root/MusicController/Sounds-3").stream = preload("res://audio/Ouch-2.wav")
	#get_node("/root/MusicController/Sounds").stream = preload("res://audio/Walk.wav")

func _process(delta):
	input = Vector2.ZERO
	if can_control:
		
		if Input.is_action_pressed("walk_left"):
			input.x = -1
		if Input.is_action_pressed("walk_right"):
			input.x = 1
		if Input.is_action_pressed("walk_down"):
			input.y = 1
		if Input.is_action_pressed("walk_up"):
			input.y = -1
		
		if get_node("/root/MusicController/Sounds").stream != preload("res://audio/Walk.wav") or ((get_node("/root/MusicController/Sounds").stream == preload("res://audio/Walk.wav")) and (get_node("/root/MusicController/Sounds").playing == false) and (Input.is_action_pressed("walk_up") or Input.is_action_pressed("walk_down") or Input.is_action_pressed("walk_right") or Input.is_action_pressed("walk_left"))):
			get_node("/root/MusicController/Sounds").stream = preload("res://audio/Walk.wav")
			get_node("/root/MusicController/Sounds").playing = true
			
		if not (Input.is_action_pressed("walk_up") or Input.is_action_pressed("walk_down") or Input.is_action_pressed("walk_right") or Input.is_action_pressed("walk_left")):
			get_node("/root/MusicController/Sounds").playing = false
		
		input = input.normalized()
		
		if Input.is_action_pressed("shoot"):
			get_node(current_gun).shoot()
		
	
	if Input.is_action_just_pressed("ui_accept"):
		stun(1)
	
	
	
	velocity*=drag
	
	if( (velocity + input * spd).length() < 1):
		$AnimatedSprite.animation = "idle"
	else:
		$AnimatedSprite.animation = "walk"
	
	if( global_position.x - get_global_mouse_position().x < 0 ):
		$AnimatedSprite.flip_h = false
	
	if( global_position.x - get_global_mouse_position().x > 0 ):
		$AnimatedSprite.flip_h = true

func _physics_process(delta):
	move_and_slide(velocity + input*spd)

func take_hit(damage:int):
	if $items.has_node("plat"):
		if randf() < 0.2:
			damage = 0
		else:
			damage+=1
	
	if Globals.devmode:
		get_node("/root/MusicController/Sounds-3").playing = true
	Globals.damage_indicator(global_position, damage)
	hp-=damage
	$GUI.hp_update()
	
	if hp <= 0:
		can_control = false
		visible = false
		Globals.death_explosion(global_position)
		SceneChanger.reset_scene()

func stun(duration:float):
	get_node("/root/MusicController/Sounds").stream = preload("res://audio/Ouch-2.wav")
	
	if Globals.devmode:
		get_node("/root/MusicController/Sounds").playing = true
	
	velocity = Vector2.ZERO
	can_control = false
	$stun_timer.wait_time = duration
	$stun_timer.start()
	var new_label = preload("res://objects/stun_label.tscn").instance()
	add_child(new_label)

func impulse(direction, force):
	velocity += Vector2(cos(direction), sin(direction)) * force

func coin_add(count:int):
	coins+=count
	$GUI.coin_update()

func switch_weapon(weapon:String):
	get_node(current_gun).visible = false
	current_gun = weapon
	get_node(current_gun).visible = true
	inventory_update()
	
	$boomerang/cooldown.stop()
	$boomerang.can_shoot = true

func inventory_update():
	$GUI/inventory/list.clear()
	$GUI.names.clear()
	$GUI.descs.clear()
	$GUI.names.append(get_node(current_gun).gun_name)
	$GUI.descs.append(get_node(current_gun).description)
	
	for elem in $items.get_children():
		$GUI.names.append(elem.item_name)
		$GUI.descs.append(elem.description)
	
	$GUI/inventory/list.clear()
	for elem in $GUI.names:
		$GUI/inventory/list.add_item(elem)
	
	for i in $GUI/inventory/list.get_item_count():
		$GUI/inventory/list.set_item_tooltip_enabled(i, false)

func spawn_item(item_name:String):
	var item:Node = load("res://objects/" + item_name + ".tscn").instance()
	item.name = item_name
	$items.add_child(item)
	inventory_update()
	item.owner = self

func new_dialogue(text:String, duration:int, emotion:String):
	$GUI/dialogue.visible = true
	$GUI/dialogue/AnimatedSprite.animation = emotion
	$GUI/dialogue/RichTextLabel.bbcode_text = text
	$GUI/dialogue/RichTextLabel.percent_visible = 0
	$GUI/dialogue/Timer.wait_time = duration
	$GUI/dialogue/Timer.start()

func heal(h:int):
	hp=clamp(hp+h, 0, max_hp)
	$GUI.hp_update()

"""
Сигналы
"""

func _on_stun_timer_timeout():
	can_control = true
