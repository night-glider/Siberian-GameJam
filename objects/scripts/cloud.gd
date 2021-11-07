extends Area2D


var path:PoolVector2Array
var nav
var player

var hp = 5

func _ready():
	nav = get_parent().get_node("Navigation2D")


func _process(delta):
	if player == null:
		player = get_parent().get_node("player")
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
