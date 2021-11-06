extends Node2D

var player:Node = null
export(Array, String) var item_pool

func _on_Area2D_body_entered(body):
	if body.name == "player":
		player = body
		$AnimatedSprite.animation = "open"
		$Panel.visible = true

func _on_Area2D_body_exited(body):
	if body.name == "player":
		$AnimatedSprite.animation = "idle"
		$Panel.visible = false

func _process(delta):
	if $Panel.visible:
		if player.coins < 10:
			$Panel/Button.disabled = true
		else:
			$Panel/Button.disabled = false
		
		if player.coins < 20:
			$Panel/Button2.disabled = true
		else:
			$Panel/Button2.disabled = false

"""
func spawn_gun():
	var n = rand_range(0, guns_pool.size())
	var new_gun = guns_pool[n]
	while player.get_node(player.current_gun).name == new_gun:
		n = rand_range(0, guns_pool.size())
		new_gun = guns_pool[n]
	player.switch_weapon(new_gun)
"""

func spawn_item():
	for elem in item_pool:
		if not player.has_node("items/"+elem):
			player.spawn_item(elem)
			return

func _on_Button_pressed():
	player.coin_add(-10)
	spawn_item()

func _on_Button2_pressed():
	player.coin_add(-20)
