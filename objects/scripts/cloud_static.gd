extends Area2D


func _process(delta):
	$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h

func take_hit(damage):
	Globals.damage_indicator(position, damage)
	
	Globals.coin_spawn(position, 200, 100)
	Globals.death_explosion(global_position)
	Globals.death_explosion(global_position + Vector2(50,50))
	Globals.death_explosion(global_position + Vector2(-50,-50))
	Globals.death_explosion(global_position + Vector2(-50,50))
	Globals.death_explosion(global_position + Vector2(50,-50))
	queue_free()
