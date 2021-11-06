extends Area2D

export(String, MULTILINE) var dialogue_text = ""
export(bool) var oneshot = true
export(int, 10, 100) var duration = 10

func _on_dialogue_trigger_body_entered(body):
	if body.name == "player":
		body.new_dialogue(dialogue_text, duration)
		if oneshot:
			queue_free()
