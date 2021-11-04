extends Node

var player
func change_scene(scene_name:String, spawnpoint_id:int):
	player = get_tree().current_scene.get_node("player")
	get_tree().current_scene.remove_child(player)
	get_tree().change_scene("res://"+scene_name+".tscn")
	add_child(player)
	get_tree().current_scene.add_child(player)
	

func _process(delta):
	pass
	#change_scene("test", 0)
