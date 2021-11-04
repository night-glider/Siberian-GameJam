extends Node2D


func _process(delta):
	position.y = lerp(position.y, -50, 0.1)
	modulate.a = lerp(modulate.a, 0, 0.05)
	if modulate.a < 0.01:
		queue_free()
	
