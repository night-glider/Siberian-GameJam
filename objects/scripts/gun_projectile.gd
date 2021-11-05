extends Area2D


var damage
var velocity:Vector2

func _process(delta):
	position += velocity

func _on_Area2D_body_shape_entered(body_id, body, body_shape, local_shape):
	if body.is_in_group("can_be_hit"):
		body.take_hit(damage)
	queue_free()
