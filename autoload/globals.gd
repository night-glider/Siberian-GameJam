extends Node
var damg_ind = preload("res://objects/damage_indicator.tscn")
var coin = preload("res://objects/coin.tscn")

func damage_indicator(pos:Vector2, damage:int):
	var new = damg_ind.instance()
	get_tree().current_scene.add_child(new)
	new.global_position = pos
	new.init(damage)

func coin_spawn(center:Vector2, r:float, count:int):
	for i in count:
		var new = coin.instance()
		get_tree().current_scene.add_child(new)
		var angle = rand_range(-PI, PI)
		var dist = rand_range(0, r)
		new.global_position.x = center.x + cos(angle)*dist
		new.global_position.y = center.y + sin(angle)*dist

func _process(delta):
	if Input.is_action_just_pressed("delete_save"):
		var dir = Directory.new()
		dir.open("user://")
		dir.list_dir_begin()
		var file = dir.get_next()
		while file != "":
			dir.remove(file)
			file = dir.get_next()
