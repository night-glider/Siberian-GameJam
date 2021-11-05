extends Button

func _init():
	self.connect("pressed", self, "_exit_from_game")

func _exit_from_game():
	get_tree().quit()
