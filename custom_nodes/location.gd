extends YSort
class_name location

export(Rect2) var bounding_box

func _ready():
	var check = File.new() 
	var player_res
	if check.file_exists("res://savedata/player.tscn"):
		player_res = load("res://savedata/player.tscn")
	else:
		player_res = load("res://objects/player.tscn")
	var player = player_res.instance()
	player.position = get_node("spawn_point"+str(SceneChanger.spawnpoint)).position
	add_child(player)
