extends Node

var player = null
var spawnpoint = 0

func change_scene(scene_name:String, id:int):
	player = get_tree().current_scene.get_node("player")
	spawnpoint = id
	print("1")
	get_tree().current_scene.remove_child(player)
	print("2")
	var packed_scene = PackedScene.new()
	var packed_player = PackedScene.new()
	packed_scene.pack(get_tree().get_current_scene())
	packed_player.pack(player)
	ResourceSaver.save("res://savedata/" + get_tree().get_current_scene().name + ".tscn", packed_scene)
	ResourceSaver.save("res://savedata/player.tscn", packed_player)
	var temp_file = File.new() 
	if temp_file.file_exists("res://savedata/" + scene_name + ".tscn"):
		get_tree().change_scene("res://savedata/"+ scene_name+".tscn")
	else:
		get_tree().change_scene("res://"+scene_name+".tscn")
	print("4")
	
