extends Control
## The screen that appears when you open the game
## Character select for the 2 players
class_name Start_Screen

func _ready() -> void:
	# Signal connections
	
	%play.pressed.connect(_play_pressed)
	%quit.pressed.connect(_quit_pressed)

func _play_pressed() -> void:
	pass

func _quit_pressed() -> void:
	get_tree().quit()
