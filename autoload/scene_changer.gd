extends Node

var player = null
var spawnpoint = 0

var current_scene:String
var current_scene_id:int

func reset_scene():
	var scene_name = current_scene
	spawnpoint = current_scene_id
	
	var temp_file = File.new()
	if temp_file.file_exists("user://" + scene_name + ".tscn"):
		get_tree().change_scene("user://"+ scene_name+".tscn")
	else:
		get_tree().change_scene("res://locations/"+scene_name+".tscn")
	

func change_scene(scene_name:String, id:int):
	print_debug("Changed scene to " + scene_name + "\n with spawnpoint_id " + str(id))
	
	current_scene = scene_name
	current_scene_id = id
	
	player = get_tree().current_scene.get_node("player")
	spawnpoint = id
	get_tree().current_scene.remove_child(player)
	var packed_scene = PackedScene.new()
	var packed_player = PackedScene.new()
	packed_scene.pack(get_tree().get_current_scene())
	packed_player.pack(player)
	ResourceSaver.save("user://" + get_tree().get_current_scene().name + ".tscn", packed_scene)
	ResourceSaver.save("user://player.tscn", packed_player)
	var temp_file = File.new()
	if temp_file.file_exists("user://" + scene_name + ".tscn"):
		get_tree().change_scene("user://"+ scene_name+".tscn")
	else:
		get_tree().change_scene("res://locations/"+scene_name+".tscn")
	
