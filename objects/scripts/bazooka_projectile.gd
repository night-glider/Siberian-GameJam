extends Area2D


var damage = 0
var velocity:Vector2

func _process(delta):
	velocity*=1.1
	position += velocity

func explosion():
	var nodes = $Area2D.get_overlapping_areas()
	for body in nodes:
		if body.is_in_group("can_be_hit"):
			body.take_hit(damage)
	
	nodes = $Area2D.get_overlapping_bodies()
	for body in nodes:
		if body.is_in_group("can_be_hit"):
			body.take_hit(damage)
	
	Globals.death_explosion( global_position)
	
	queue_free()

func _on_Area2D_body_shape_entered(body_id, body, body_shape, local_shape):
	explosion()

func _on_Area2D_area_entered(area):
	if area.is_in_group("can_be_hit"):
		explosion()
