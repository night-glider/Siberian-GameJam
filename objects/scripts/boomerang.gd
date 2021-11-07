extends Node2D

export var radius = 25
export var recoil = 200
export var cooldown_time = 3

export(String) var gun_name
export(String, MULTILINE) var description
export var projectile_speed = 15

var can_shoot = true
var target_pos = Vector2.ZERO
var projectile = preload("res://objects/boomerang_projectile.tscn")

func _process(delta):
	var angle = get_global_mouse_position().angle_to_point(global_position - position)
	rotation = angle
	target_pos.x = cos(angle) * radius
	target_pos.y = sin(angle) * radius
	position = lerp(position, target_pos, 0.1)

func shoot():
	if can_shoot:
		visible = false
		can_shoot = false
		$cooldown.wait_time = cooldown_time
		$cooldown.start()
	
		var new_proj = projectile.instance()
		get_tree().current_scene.add_child(new_proj)
		new_proj.global_position = $shoot_here.global_position
		new_proj.velocity = Vector2(projectile_speed, 0).rotated(rotation)
		new_proj.damage = 2
		var chance = randf()
		if chance < 0.25:
			new_proj.follow=true

func _on_cooldown_timeout():
	can_shoot = true
	visible = true
