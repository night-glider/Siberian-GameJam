extends Node2D

export var stage = 0

func _ready():
	if stage == 1:
		$AnimatedSprite.animation = "broken"

func _on_Area2D_body_entered(body):
	if body.name == "player" and $AnimatedSprite.animation != "broken":
		$Panel/RichTextLabel.bbcode_text = "Заплати всего [u][color=red]" + str(body.coins+1) + "монет[/color][/u] и получи свежую \n[wave amp=50 freq=2][color=yellow]Г А З Е Т У[/color][/wave]"
		$Panel.visible = true
		stage = 1
	if body.name == "player" and $AnimatedSprite.animation == "broken":
		body.new_dialogue("Серьёзно??? Его уже успели сломать? Похоже придётся идти [color=yellow]домой[/color]", 10, "sad")


func _on_Area2D_body_exited(body):
	if body.name == "player":
		$Panel.visible = false



func _on_Area2D2_body_exited(body):
	if body.name == "player" and stage == 1:
		$AnimatedSprite.animation = "broken"
