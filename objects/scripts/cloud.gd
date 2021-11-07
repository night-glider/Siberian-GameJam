extends Area2D


var path:PoolVector2Array
var nav
var player

var hp = 5

var projectile = preload("res://objects/gun_projectile.tscn")

func _ready():
	nav = get_parent().get_node("Navigation2D")
	$Timer.wait_time = rand_range(3,6)
	$Timer.start()


func _process(delta):
	if player == null:
		player = get_parent().get_node("player")
		return
	
	if player.global_position.distance_to(global_position) > 500:
		return
	
	path = nav.get_simple_path(position, player.position)
	if path.size() < 1:
		return
	position = position.move_toward(path[1], 1)
	

func take_hit(damage):
	if hp <= 0:
		return
	Globals.damage_indicator(position, damage)
	hp-=damage
	if hp <= 0:
		Globals.coin_spawn(position, 100, 10)
		Globals.death_explosion(global_position)
		queue_free()
	



func _on_Cloud_body_entered(body):
	if body.name == "player":
		body.take_hit(1)
		body.impulse(body.position.angle_to_point(position), 1000)


func _on_Timer_timeout():
	for i in [-0.3,0,0.3]:
		var new_proj = projectile.instance()
		get_tree().current_scene.add_child(new_proj)
		var angle = player.global_position.angle_to_point(global_position)
		new_proj.velocity = Vector2(3, 0).rotated(angle + i)
		new_proj.global_position = global_position + new_proj.velocity*20
		new_proj.damage = 1
