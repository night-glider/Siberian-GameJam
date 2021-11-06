extends Node

export(String) var item_name
export(String, MULTILINE) var description


func _on_Timer_timeout():
	var chance = randf()
	if chance < 0.05:
		get_parent().get_parent().heal(1)
