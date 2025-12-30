extends Node2D
## The parent / container for entities, characters & stuff
class_name EntityContainer

@export var player_1 : Character
@export var player_2 : Character


func _ready() -> void:
	if get_children().size() >= 3:
		printerr("2 CHARACTERS ONLY!")
		return
	
	Global.player_1 = player_1
	Global.player_2 = player_2
	
	Global.current_turn = player_1
	
	if (
		Global.player_1.control_type == Global.player_1.control_types.QL_AI and
		Global.player_2.control_type == Global.player_2.control_types.QL_AI
		): # If both characters are Q learning AI
		printerr("ONLY 1 CHARACTER CAN BE Q LEARNING AI!")
		return
