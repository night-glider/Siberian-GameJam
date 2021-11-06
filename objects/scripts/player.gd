extends KinematicBody2D

export var spd = 200 #скорость
export var drag = 0.8 #коэффициент трения


var velocity = Vector2(0,0) #вектор движения
var can_control = true #может ли игрок контроллировать персонажа
var input = Vector2(0,0) #то, куда игрок ХОЧЕТ пойти
var current_gun

func _ready():
	$Camera2D.limit_left = get_parent().bounding_box.position.x
	$Camera2D.limit_right = get_parent().bounding_box.end.x
	$Camera2D.limit_top = get_parent().bounding_box.position.y
	$Camera2D.limit_bottom = get_parent().bounding_box.end.y
	current_gun = $gun
	
	$GUI.names.append($gun.gun_name)
	$GUI.descs.append($gun.description)
	
	for elem in $items.get_children():
		$GUI.names.append(elem.item_name)
		$GUI.descs.append(elem.description)
	
	$GUI/inventory/list.clear()
	for elem in $GUI.names:
		$GUI/inventory/list.add_item(elem)
	
	for i in $GUI/inventory/list.get_item_count():
		$GUI/inventory/list.set_item_tooltip_enabled(i, false)

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
		input = input.normalized()
		
		
		if Input.is_action_pressed("shoot"):
			current_gun.shoot()
		
	
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
	
	
	if Input.is_action_just_pressed("delete_save"):
		var dir = Directory.new()
		dir.open("user://")
		dir.list_dir_begin()
		var file = dir.get_next()
		while file != "":
			dir.remove(file)
			file = dir.get_next()


func _physics_process(delta):
	move_and_slide(velocity + input*spd)

func take_hit(damage:int):
	Globals.damage_indicator(global_position, damage)

func stun(duration:float):
	velocity = Vector2.ZERO
	can_control = false
	$stun_timer.wait_time = duration
	$stun_timer.start()
	var new_label = preload("res://objects/stun_label.tscn").instance()
	add_child(new_label)

func impulse(direction, force):
	velocity += Vector2(cos(direction), sin(direction)) * force


"""
Сигналы
"""

func _on_stun_timer_timeout():
	can_control = true
