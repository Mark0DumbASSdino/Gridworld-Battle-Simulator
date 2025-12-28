extends Node2D
## Component that gets activated when the 
## control type is player
class_name PlayerComponent

@onready var p : Character = get_parent()

@export var grid_limit_component : GridLimitComponent

func move_handle_player() -> void:
	if p.energy <= 0:
		# Disallows moving when you ran out of energy
		return
	
	if Input.is_action_just_pressed("right"):
		grid_limit_component.move_x(1)
	if Input.is_action_just_pressed("left"):
		grid_limit_component.move_x(-1)
	if Input.is_action_just_pressed("up"):
		grid_limit_component.move_y(-1)
	if Input.is_action_just_pressed("down"):
		grid_limit_component.move_y(1)
