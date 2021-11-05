extends Button

func start_game(): 
	print_debug("Changed Scene")
	var music_node = get_node("/root/MusicController").get_node("AmbietMusic") # Getting Music Node
	music_node.volume_db = lerp(int(music_node.volume_db), -80, 0.3) # Music volume decrease
	# Change Scene script
	
func _init(): 
	self.connect("pressed", self, "start_game") # Binding buttons press event on start_game func

func _ready():
	var music_node = get_node("/root/MusicController") # Music node
	music_node = music_node.get_node("AmbietMusic") 
	music_node.stream = preload("res://HomeMenu.mp3") # Music setter
	music_node.playing = true
