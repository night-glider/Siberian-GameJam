extends MarginContainer

func _ready():
	var MusicNode = get_node("/root/MusicController/Music")
	get_node("Settings/VBoxContainer/HBoxContainer/VBoxContainer/MusicControl/MusicVolume-Slider").value = 75
	get_node("Settings/VBoxContainer/HBoxContainer/VBoxContainer/SoundsControl/SoundsVolume-Slider").value = 75
	MusicNode.stream = preload("res://audio/Home.mp3")
	MusicNode.playing = true
	get_node("Menu").visible = true
	get_node("Settings").visible = false
	
	
func _on_Start_pressed():
	get_node("/root/MusicController/Music").stream = preload("res://audio/Forest.mp3")
	get_node("/root/MusicController/Music").playing = true
	Globals.delete_save()
	get_tree().change_scene("res://locations/loc_home.tscn")

func _on_Exit_pressed():
	print_debug("Bye!")
	get_tree	().quit()

func _on_MainWindow_ready():
	var main = get_node("Menu")
	var settings = get_node("Settings")
	main.visible = true
	settings.visible = false

func _on_Settings_pressed():
	get_node("Menu").visible = false
	get_node("Settings").visible = true


func _on_ExitFromSettings_pressed():
	get_node("Settings").visible = false
	get_node("Menu").visible = true


func _on_MusicVolumeSlider_value_changed(value):
	get_node("/root/MusicController/Music").volume_db = -90 + value
