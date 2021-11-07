extends Particles2D

func init(pos:Vector2, direction:float, particle:ParticlesMaterial, number:int, time:float):
	process_material = particle
	global_position = pos
	amount = number
	lifetime = time
	rotation = direction
	$Timer.wait_time = time
	$Timer.start()
	
	emitting = true


func _on_Timer_timeout():
	queue_free()
