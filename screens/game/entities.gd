extends Node2D
## The parent / container for entities, characters & stuff
class_name EntityContainer

@export var player_1 : Character
@export var player_2 : Character

func _ready() -> void:
	if get_children().size() >= 3:
		printerr("2 PLAYERS ONLY!")
		return
	
	Global.player_1 = player_1
	Global.player_2 = player_2
	
	Global.current_turn = player_1
