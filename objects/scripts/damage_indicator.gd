extends Node2D

var a = 1

func init(damage):
	$Label.text = str(damage)

func _ready():
	modulate.a = 2

func _process(delta):
	position.y -= a
	a-=0.01
	modulate.a = lerp(modulate.a, 0, 0.05)
	if modulate.a < 0.01:
		queue_free()
	
