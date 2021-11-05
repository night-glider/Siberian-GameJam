extends Node2D

export var radius = 25
export var recoil = 500
export var cooldown_time = 0.1

var can_shoot = true
var target_pos = Vector2.ZERO

func _process(delta):
	var angle = get_global_mouse_position().angle_to_point(global_position - position)
	rotation = angle
	target_pos.x = cos(angle) * radius
	target_pos.y = sin(angle) * radius
	position = lerp(position, target_pos, 0.1)
	
	
	if Input.is_action_pressed("shoot") and can_shoot:
		get_parent().impulse(rotation-PI, recoil)
		can_shoot = false
		$cooldown.wait_time = cooldown_time
		$cooldown.start()
	
	if abs(rotation) > PI/2:
		$Sprite.flip_v = true
	else:
		$Sprite.flip_v = false

func _on_cooldown_timeout():
	can_shoot = true
