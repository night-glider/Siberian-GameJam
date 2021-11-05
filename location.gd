extends Node2D
class_name location

func _ready():
	var player_res = load("res://savedata/player.tscn")
	if player_res == null:
		player_res = load("res://player.tscn")
	var player = player_res.instance()
	player.position = get_node("spawn_point"+str(SceneChanger.spawnpoint)).position
	add_child(player)
