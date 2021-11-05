extends Node

export(String) var item_name
export(String, MULTILINE) var description


func _on_Timer_timeout():
	var chance = randf()
	if chance < 0.1:
		get_parent().get_parent().stun(1)
