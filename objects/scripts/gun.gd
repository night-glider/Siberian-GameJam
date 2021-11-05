extends Node2D

export var radius = 25
export var recoil = 200
export var cooldown_time = 0.2

export(String) var gun_name
export(String, MULTILINE) var description

var can_shoot = true
var target_pos = Vector2.ZERO

func _process(delta):
	var angle = get_global_mouse_position().angle_to_point(global_position - position)
	rotation = angle
	target_pos.x = cos(angle) * radius
	target_pos.y = sin(angle) * radius
	position = lerp(position, target_pos, 0.1)
	
	
	if abs(rotation) > PI/2:
		$Sprite.flip_v = true
	else:
		$Sprite.flip_v = false

func shoot():
	if can_shoot:
		get_parent().impulse(rotation-PI, recoil)
		can_shoot = false
		$cooldown.wait_time = cooldown_time
		$cooldown.start()
		
		var chance = randf()
		if chance < 0.2:
			get_parent().stun(1)

func _on_cooldown_timeout():
	can_shoot = true
