extends Node2D


var player
var a = 0

func _ready():
	player = get_parent().get_node("player")

func _process(delta):
	global_position = global_position.move_toward(player.global_position, a)
	a+=0.2
	if global_position.distance_to(player.global_position) < 10:
		queue_free()
