extends Area2D

export(String) var location_name
export(int) var spawn_point_id = 0


func _on_loc_change_trigger_body_entered(body):
	if body.name == "player":
		print("hey")
		SceneChanger.change_scene(location_name, spawn_point_id)
		
