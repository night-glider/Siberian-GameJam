extends Area2D


var damage = 0
var velocity:Vector2

func _process(delta):
	position += velocity

func _on_Area2D_body_shape_entered(body_id, body, body_shape, local_shape):
	if body.is_in_group("can_be_hit"):
		body.take_hit(damage)
	Globals.projectile_explosion(global_position, velocity.angle()+PI)
	queue_free()


func _on_Area2D_area_entered(area):
	if area.is_in_group("can_be_hit"):
		area.take_hit(damage)
		Globals.projectile_explosion(global_position, velocity.angle()+PI)
		queue_free()
