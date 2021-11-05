extends Node
var damg_ind = preload("res://objects/damage_indicator.tscn")


func damage_indicator(pos:Vector2, damage:int):
	var new = damg_ind.instance()
	get_tree().current_scene.add_child(new)
	new.global_position = pos
	new.init(damage)
