extends Node2D

export var radius = 25
export var recoil = 200
export var cooldown_time = 0.2

export(String) var gun_name
export(String, MULTILINE) var description
export var projectile_speed = 5

var can_shoot = true
var target_pos = Vector2.ZERO
var projectile = preload("res://objects/gun_projectile.tscn")

func _ready():
	get_node("/root/MusicController/Sounds-2").stream = preload("res://audio/Gun.wav")

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
	
		var new_proj = projectile.instance()
		get_tree().current_scene.add_child(new_proj)
		new_proj.global_position = $shoot_here.global_position
		new_proj.velocity = Vector2(projectile_speed, 0).rotated(rotation)
		new_proj.damage = 1
		chance = randf()
		get_node("/root/MusicController/Sounds-2").playing = true
		
		if chance < 0.1:
			new_proj.damage*=2

func _on_cooldown_timeout():
	can_shoot = true
