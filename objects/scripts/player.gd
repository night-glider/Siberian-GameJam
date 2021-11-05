extends KinematicBody2D

export var spd = 200 #скорость
export var drag = 0.8 #коэффициент трения

var velocity = Vector2(0,0) #вектор движения
var can_control = true #может ли игрок контроллировать персонажа
var input = Vector2(0,0) #то, куда игрок ХОЧЕТ пойти

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
