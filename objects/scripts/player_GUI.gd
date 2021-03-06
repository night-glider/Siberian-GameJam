extends CanvasLayer


var descs = []
var names = []
var inventory_active = false
var n = -99999

func _process(delta):
	if inventory_active:
		$inventory.anchor_left = lerp($inventory.anchor_left, 0.5, 0.1)
	else:
		$inventory.anchor_left = lerp($inventory.anchor_left, 0.99, 0.1)
	
	if $dialogue.visible:
		$dialogue/RichTextLabel.percent_visible+=0.01
	
	$coin.rect_scale = lerp($coin.rect_scale, Vector2(2,2), 0.1)
	$coins_label.rect_scale = lerp($coins_label.rect_scale, Vector2(1,1), 0.1)
	
	$dialogue/AnimatedSprite.rotation_degrees = sin(n) * 10
	n+=PI/180

func coin_update():
	$coin.rect_scale*=1.1
	$coins_label.rect_scale*=1.1
	$coins_label.text = "x" + str(get_parent().coins)

func hp_update():
	$hp.margin_right = get_parent().hp*64

func _on_inventory_list_item_selected(index):
	$inventory/Panel/label.bbcode_text = descs[index]

func _on_inventory_mouse_entered():
	inventory_active = true

func _on_inventory_mouse_exited():
	inventory_active = false
	$inventory/list.unselect_all()
	$inventory/Panel/label.bbcode_text = ""


func _on_Timer_timeout():
	$dialogue.visible = false
