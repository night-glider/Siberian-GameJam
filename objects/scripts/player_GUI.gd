extends CanvasLayer


var descs = []
var names = []
var inventory_active = false


func _process(delta):
	if inventory_active:
		$inventory.anchor_left = lerp($inventory.anchor_left, 0.5, 0.1)
	else:
		$inventory.anchor_left = lerp($inventory.anchor_left, 0.99, 0.1)

func _on_inventory_list_item_selected(index):
	$inventory/Panel/label.bbcode_text = descs[index]

func _on_inventory_mouse_entered():
	inventory_active = true

func _on_inventory_mouse_exited():
	inventory_active = false
	$inventory/list.unselect_all()
	$inventory/Panel/label.bbcode_text = ""
