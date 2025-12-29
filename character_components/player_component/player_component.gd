extends Node2D
## Component that is used when the 
## control type is player
## All its inputs and stuff handled here, move and attack
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

func attack_handle_player() -> void:
	if p.energy <= 0:
		# Disallows attacking when you ran out of energy
		return
	
	if (
			Input.is_action_just_pressed("attack") and
			p.allow_attack
		):
		p.attacked()

func end_turn_handle_player() -> void:
	
	if (
			Input.is_action_just_pressed("end_turn") and 
			Global.current_turn == p and 
			p.allow_end_turn
			):
		if p == Global.player_1:
			Global.current_turn = Global.player_2
			Global.turn_changed.emit(Global.player_2)
		elif p == Global.player_2:
			Global.current_turn = Global.player_1
			Global.turn_changed.emit(Global.player_1)
