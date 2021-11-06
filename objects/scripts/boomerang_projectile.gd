extends Area2D

var damage = 0
var velocity:Vector2
var follow = false
var ret = false
var player:Node

func _ready():
	player = get_tree().current_scene.get_node("player")

func _process(delta):
	if ret:
		velocity+=velocity/30
		if follow:
			global_position = global_position.move_toward(player.global_position, velocity.length())
		else:
			position += velocity
	else:
		velocity-=velocity/30
		
		if abs(velocity.length()) < 1:
			ret = true
			velocity*=-1
		
		position += velocity
	
	rotation_degrees+=5

func _on_Area2D_body_shape_entered(body_id, body, body_shape, local_shape):
	if body.is_in_group("can_be_hit"):
		body.take_hit(damage)
	
	if body.name == "player":
		queue_free()


func _on_Area2D_area_entered(area):
	if area.is_in_group("can_be_hit"):
		area.take_hit(damage)


func _on_Timer_timeout():
	queue_free()
