extends Node2D
## Component that is used when the
## control type is Scripted AI
## The inputs like movement & attack are handled here
class_name ScriptedAIComponent

@onready var p : Character = get_parent()

@export var grid_limit_component : GridLimitComponent

func _ready() -> void:
	pass

func move_handle_script_ai() -> void:
	if p.energy <= 0:
		# Disallows moving when out of energy
		return
	
	
	
	if p.distance_from_opponent.x > 0:
		grid_limit_component.move_x(1)
	elif p.distance_from_opponent.x < 0:
		grid_limit_component.move_x(-1)
	
	if p.distance_from_opponent.y > 0:
		grid_limit_component.move_y(1)
	elif p.distance_from_opponent.y < 0:
		grid_limit_component.move_y(-1)

func attack_handle_script_ai() -> void:
	if p.energy <= 0:
		# Disallows attacking when out of energy
		return
	
	if (
			p.distance_from_opponent.length() <= 1 and
			p.allow_attack
		):
		p.attacked()

func end_turn_handle_scripted_ai() -> void:
	
	if (
			p.energy <= 0 and # The scripted AI will automatically end turn once out of energy) 
			Global.current_turn == p and 
			p.allow_end_turn
			):
			
		if p == Global.player_1:
			Global.current_turn = Global.player_2
			Global.turn_changed.emit(Global.player_2)
		
		elif p == Global.player_2:
			Global.current_turn = Global.player_1
			Global.turn_changed.emit(Global.player_1)
