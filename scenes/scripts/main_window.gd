extends MarginContainer

func _ready():
	var MusicNode = get_node("/root/MusicController/Music")
	get_node("Settings/VBoxContainer/HBoxContainer/VBoxContainer/MusicControl/MusicVolume-Slider").value = 75
	get_node("Settings/VBoxContainer/HBoxContainer/VBoxContainer/SoundsControl/SoundsVolume-Slider").value = 75
	MusicNode.stream = preload("res://audio/Home.mp3")
	MusicNode.playing = true
	get_node("Menu").visible = true
	get_node("Settings").visible = false
	
	get_node("Background").texture = preload("res://img/RealBg.jpg")
	
func _on_Start_pressed():
	get_node("/root/MusicController/Music").stream = preload("res://audio/Forest.mp3")
	get_node("/root/MusicController/Music").playing = true
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


# Godot moment
func _on_DevModeBox_toggled(button_pressed):
	if button_pressed:
		get_node("Background").texture = preload("res://sprites/icon.png")
		get_node("Menu/HBoxContainer/VBoxContainer/GameTitle").text = "Godot Momet!"
		get_node("Menu/HBoxContainer/VBoxContainer/VBoxContainer/Start").text = "TAPESSSS"
		get_node("Menu/HBoxContainer/VBoxContainer/VBoxContainer/Settings").text = "BLUE TAPE USAGE"
		get_node("Menu/HBoxContainer/VBoxContainer/VBoxContainer/Exit").text = "Is that... Real life?"
		get_node("Settings/VBoxContainer/HBoxContainer/VBoxContainer/MusicControl/MusicVolume-Title").text = "That perfect music"
		get_node("Settings/VBoxContainer/HBoxContainer/VBoxContainer/SoundsControl/SoundsVolume-Title").text = "OFFF SOUNDS!"
		get_node("Settings/VBoxContainer/HBoxContainer/VBoxContainer2/DevMode-Box").text = "BEBRA MODE"
		get_node("/root/MusicController/Music").stream = preload("res://audio/Devmode.mp3")
		get_node("/root/MusicController/Music").autoplay = true
		get_node("/root/MusicController/Music").playing = true
		Globals.devmode = true
		
	else: 
		get_node("Background").texture = preload("res://img/RealBg.jpg")
		get_node("Menu/HBoxContainer/VBoxContainer/GameTitle").text = "I Just want\nto read my\nNewspaper!"
		get_node("Menu/HBoxContainer/VBoxContainer/VBoxContainer/Start").text = "Старт"
		get_node("Menu/HBoxContainer/VBoxContainer/VBoxContainer/Settings").text = "Настройки"
		get_node("Menu/HBoxContainer/VBoxContainer/VBoxContainer/Exit").text = "Выход"
		get_node("Settings/VBoxContainer/HBoxContainer/VBoxContainer/MusicControl/MusicVolume-Title").text = "Громкость музыки"
		get_node("Settings/VBoxContainer/HBoxContainer/VBoxContainer/SoundsControl/SoundsVolume-Title").text = "Громкость "
		get_node("Settings/VBoxContainer/HBoxContainer/VBoxContainer2/DevMode-Box").text = "Режим разработчика"
		get_node("/root/MusicController/Music").stream = preload("res://audio/Home.mp3")
		get_node("/root/MusicController/Music").autoplay = true
		get_node("/root/MusicController/Music").playing = true
		Globals.devmode = false


func _on_DeleteProgress_pressed():
	Globals.delete_save()
