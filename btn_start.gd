extends Button

func start_game(): 
	print_debug("Changed Scene")
	var music_node = get_node("/root/MusicController").get_node("AmbietMusic") # Getting Music Node
	music_node.volume_db = lerp(int(music_node.volume_db), 0, 0.1) # Music volume decrease

func _init(): 
	# The Place where Errors Beggins
	var music_node = get_node("/root/MusicController") # Music node
	music_node = music_node.get_node("AmbietMusic") 
	music_node.stream.set_stream(preload("res://HomeMenu.mp3")) # Music setter
	# The Place where Errors Ends
	self.connect("pressed", self, "start_game") # Binding buttons press event on start_game func
