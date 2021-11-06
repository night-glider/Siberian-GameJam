tool
extends YSort
class_name location

export(Rect2) var bounding_box

func _ready():
	if not Engine.editor_hint:
		var check = File.new() 
		var player_res
		if check.file_exists("user://player.tscn"):
			player_res = load("user://player.tscn")
		else:
			player_res = load("res://objects/player.tscn")
		var player = player_res.instance()
		player.position = get_node("spawn_point"+str(SceneChanger.spawnpoint)).position
		add_child(player)

func _process(delta):
	update()

func _draw():
	if Engine.editor_hint:
		draw_rect( bounding_box, Color.red, false, 20)
