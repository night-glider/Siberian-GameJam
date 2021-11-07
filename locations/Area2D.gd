extends Area2D



func _on_Area2D_body_entered(body):
	if body.name == "player" and get_parent().get_node("machine").stage == 10:
		get_tree().change_scene("res://scenes/ending.tscn")
