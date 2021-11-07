extends Control

func _ready():
	$RichTextLabel.percent_visible = 0
	$RichTextLabel.modulate.a = 0
	get_node("/root/MusicController/Music").playing = false

func _process(delta):
	$RichTextLabel.percent_visible+=0.0005
	$RichTextLabel.modulate.a+=0.002


func _on_Timer_timeout():
	Globals.delete_save()
	get_tree().quit()
