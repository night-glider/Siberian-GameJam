extends MarginContainer

func _ready():
	var music_node = get_node("/root/MusicController") # Music node
	music_node = music_node.get_node("AmbietMusic") 
	music_node.stream = preload("res://audio/HomeMenu.mp3") # Music setter
	music_node.playing = true

func _on_Start_pressed():
	print_debug("Game started")
	var music_node = get_node("/root/MusicController").get_node("AmbietMusic") # Getting Music Node
	music_node.volume_db = lerp(int(music_node.volume_db), -80, 0.3) # Music volume decrease
	# Change Scene script

func _on_Exit_pressed():
	print_debug("Bye!")
	get_tree	().quit()

func _on_Options_pressed():
	var setting = get_node("Settings")
	var mainWindow = get_node("Menu")
	mainWindow.visible = false
	setting.visible = true

func _on_MusicScrollBar_value_changed(value):
	var ambientMusic = get_node("/root/MusicController").get_node("AmbietMusic")
	ambientMusic.volume_db = -80 + value

func _on_MainWindow_ready():
	var main = get_node("Menu")
	var settings = get_node("Settings")
	main.visible = true
	settings.visible = false

func _on_SettingExitBtn_pressed():
	var setting = get_node("Settings")
	var mainWindow = get_node("Menu")
	setting.visible = false
	mainWindow.visible = true
