extends Node2D
## The parent / container for entities, characters & stuff
class_name EntityContainer

func _ready() -> void:
	if get_children().size() >= 3:
		printerr("2 PLAYERS ONLY!")
		pass
