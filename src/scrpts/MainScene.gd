extends MarginContainer

# Exit func
func _on_Exit_pressed(): get_tree().quit() 

# Settings 
func _on_Settings_pressed():
	var Menu = get_node("Menu")
	var Settings = get_node("Settings")
	
	Menu.visible = false
	Settings.visible = true

func _on_ExitFromSettings_pressed():
	var Menu = get_node("Menu")
	var Settings = get_node("Settings")
	
	Settings.visible = false
	Menu.visible = true

# Starting game
func _on_Start_pressed():
	var MusicNode = get_node("/root/MusicController").get_node("Music-stream")
	var Overlay = get_node("ColorOverlay")
	Overlay.visible = false
	
	# Changing sceen
	#var count = 3
	#while count > 0:
	#	count -= 1
	#	MusicNode.volume_db = MusicNode.volume_db - 20
	#	Overlay.modulate.a = Overlay.modulate.a + 120
	#	Overlay.visible = true
	#	yield(get_tree().create_timer(1.0), "timeout")

# Easter Egg - "You have been Godoted!"
func _on_DevModeBox_toggled(button_pressed):
	if button_pressed:
		get_node("Menu/HBoxContainer/VBoxContainer/GameTitle").text = "Godot Moment"
		get_node("/root/MusicController").get_node("Music-stream").stream = preload("res://src/music/godot_moment.mp3")
		get_node("/root/MusicController").get_node("Music-stream").playing = true
		get_node("/root/MusicController").get_node("Music-stream").autoplay = true
		get_node("Menu/HBoxContainer/VBoxContainer/VBoxContainer/Exit").text = "Blue izolenta"
		get_node("Menu/HBoxContainer/VBoxContainer/VBoxContainer/Start").text = "Rade izolenta"
		get_node("Menu/HBoxContainer/VBoxContainer/VBoxContainer/Settings").text = "BRUH izolenta"
		get_node("Settings/VBoxContainer/HBoxContainer/VBoxContainer2/DevMode-Box").text = "BEBRA MODE"
		get_node("Background").visible = true
	else: 
		get_node("Menu/HBoxContainer/VBoxContainer/GameTitle").text = "I Just want \nto read my \nNewspaper!"
		get_node("/root/MusicController").get_node("Music-stream").stream = preload("res://src/music/MenuMusic.mp3")
		get_node("/root/MusicController").get_node("Music-stream").playing = true
		get_node("/root/MusicController").get_node("Music-stream").autoplay = true
		get_node("Menu/HBoxContainer/VBoxContainer/VBoxContainer/Exit").text = "Exit"
		get_node("Menu/HBoxContainer/VBoxContainer/VBoxContainer/Start").text = "Start"
		get_node("Menu/HBoxContainer/VBoxContainer/VBoxContainer/Settings").text = "Settings"
		get_node("Settings/VBoxContainer/HBoxContainer/VBoxContainer2/DevMode-Box").text = "Developer mode"
		get_node("Background").visible = false


# Set default values  
func _ready():
	# Setting Menu as default Scene
	var Menu = get_node("Menu")
	var Settings = get_node("Settings")
	
	Menu.visible = true
	Settings.visible = false
	
	# Setting default music
	var MusicNode = get_node("/root/MusicController").get_node("Music-stream")
	MusicNode.stream = preload("res://src/music/MenuMusic.mp3")
	MusicNode.playing = true
	MusicNode.autoplay = true
	MusicNode.volume_db = -30

