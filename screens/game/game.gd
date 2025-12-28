extends Node2D
## Main game scene
## Where the combat & shit happens
class_name Game

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://screens/start/start.tscn")
