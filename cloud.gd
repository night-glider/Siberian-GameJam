extends Node2D


var path:PoolVector2Array
var nav
var player
func _ready():
	nav = get_parent().get_node("Navigation2D")
	

func _process(delta):
	
	if player == null:
		player = get_parent().get_node("player")
		return
	
	path = nav.get_simple_path(position, player.position)
	position = position.move_toward(path[1], 1)
	
