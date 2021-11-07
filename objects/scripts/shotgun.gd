extends Node2D

export var radius = 25
export var recoil = 1000
export var cooldown_time = 1

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
		$AnimatedSprite.flip_v = true
	else:
		$AnimatedSprite.flip_v = false

func shoot():
	if can_shoot:
		var chance = randf()
		if chance < 0.5:
			get_parent().impulse(rotation-PI, recoil)
		else:
			get_parent().impulse(rotation-PI, recoil*5)
		
		can_shoot = false
		$AnimatedSprite.animation = "reload"
		$cooldown.wait_time = cooldown_time
		$cooldown.start()
		
		for i in 10:
			var new_proj = projectile.instance()
			get_tree().current_scene.add_child(new_proj)
			new_proj.global_position = $shoot_here.global_position
			new_proj.velocity = Vector2(projectile_speed, 0).rotated(rotation + rand_range(-0.4,0.4))
			new_proj.damage = 1
		get_node("/root/MusicController/Sounds-2").playing = true
		
func _on_cooldown_timeout():
	can_shoot = true
	$AnimatedSprite.animation = "idle"
