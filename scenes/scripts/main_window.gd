extends MarginContainer

func _ready():
	# Music node
	var music_node = get_node("/root/MusicController").get_node("AmbietMusic")  # Music node
	music_node.stream = preload("res://audio/HomeMenu.mp3") # Music setter
	
	# Settings window node
	var settingsBar = get_node("Settings/VBoxContainer3/HBoxContainer/VBoxContainer2/MusicScrollBar")
	
	# Openned config file parser
	var file = File.new()
	file.open("res://savedata/configs.json", file.READ) # The default JSON file should be gitignored
	var json = file.get_as_text()
	var configs = JSON.parse(json).result
	file.close()
	
	# Setting configs from configs.json
	settingsBar.value = float(configs["music"])
	music_node.volume_db = float(configs["music"]) - 100
	
	
	
func _on_Start_pressed():
	print_debug("Game started")
	var music_node = get_node("/root/MusicController").get_node("AmbietMusic") # Getting Music Node
	music_node.volume_db = lerp(int(music_node.volume_db), -80, 0.3) # Music volume decrease
	# Change Scene script
	get_tree().change_scene("res://locations/loc_home.tscn")

func _on_Exit_pressed():
	print_debug("Bye!")
	get_tree	().quit()

func _on_Options_pressed():
	var setting = get_node("Settings")
	var mainWindow = get_node("Menu")
	mainWindow.visible = false
	setting.visible = true

func _on_MusicScrollBar_value_changed(value):
	# Changed Music scrollbar
	var ambientMusic = get_node("/root/MusicController").get_node("AmbietMusic")
	ambientMusic.volume_db = -80 + value
	

func _on_MainWindow_ready():
	var main = get_node("Menu")
	var settings = get_node("Settings")
	main.visible = true
	settings.visible = false

func _on_SettingExitBtn_pressed():
	# Changing visibility of some windows
	var setting = get_node("Settings")
	var mainWindow = get_node("Menu")
	setting.visible = false
	mainWindow.visible = true
	
	# Saving data 
	var data = {	}
	
	data["music"] = get_node("Settings/VBoxContainer3/HBoxContainer/VBoxContainer2/MusicScrollBar").value
	
	print_debug(data["music"])
	
	var file = File.new()
	file.open("res://savedata/configs.json", file.WRITE)
	file.store_var(to_json(data), true)
	file.close()
	
	print_debug("Saved settings data")
