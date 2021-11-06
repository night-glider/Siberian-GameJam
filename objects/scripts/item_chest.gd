extends Node2D

var player:Node = null
export(Array, String) var item_pool

func check_stock():
	if player.coins < 20:
		$Panel/Button.disabled = true
	else:
		$Panel/Button.disabled = false
	
	if player.coins < 30:
		$Panel/Button2.disabled = true
	else:
		$Panel/Button2.disabled = false
	
	for elem in item_pool:
		if not player.has_node("items/"+elem):
			return
	$Panel/out_of_stock.visible = true
	$Panel/Button.disabled = true
	$Panel/Button2.disabled = true

func _on_Area2D_body_entered(body):
	if body.name == "player":
		player = body
		
		check_stock()
		
		$AnimatedSprite.animation = "open"
		$Panel.visible = true

func _on_Area2D_body_exited(body):
	if body.name == "player":
		$AnimatedSprite.animation = "idle"
		$Panel.visible = false

func spawn_item():
	for elem in item_pool:
		if not player.has_node("items/"+elem):
			player.spawn_item(elem)
			
			check_stock()
			return
	

func _on_Button_pressed():
	player.coin_add(-20)
	spawn_item()

func _on_Button2_pressed():
	player.coin_add(-30)
	spawn_item()
