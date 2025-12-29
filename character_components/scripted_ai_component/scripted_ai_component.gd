extends Node2D
## Component that is used when the
## control type is Scripted AI
## The inputs like movement & attack are handled here
class_name ScriptedAIComponent

@onready var p : Character = get_parent()

@export var grid_limit_component : GridLimitComponent

enum states {
	AGGRESSIVE, # move towards enemy & attacks
	DEFENSIVE, # runs away directly
}
var current_state : states
var def_attacks_amount : int = 1 ## For the defensive state

func _ready() -> void:
	pass

func move_handle_script_ai() -> void:
	if p.energy <= 0:
		# Disallows moving when out of energy
		return
	
	_determine_state()
	
	if current_state == states.AGGRESSIVE:
		_move_toward()
	elif current_state == states.DEFENSIVE:
		_move_away()

func attack_handle_script_ai() -> void:
	if p.energy <= 0:
		# Disallows attacking when out of energy
		return
	
	if current_state == states.AGGRESSIVE:
		
		if (
				p.distance_from_opponent.length() <= 1 and
				p.allow_attack
			):
			p.attacked()
		
	elif current_state == states.DEFENSIVE:
		
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
		
		def_attacks_amount = 1
		
		if p == Global.player_1:
			Global.current_turn = Global.player_2
			Global.turn_changed.emit(Global.player_2)
		
		elif p == Global.player_2:
			Global.current_turn = Global.player_1
			Global.turn_changed.emit(Global.player_1)

func _determine_state() -> void:
	match p.get_hp_state():
		p.hp_states.HIGH:
			current_state = states.AGGRESSIVE
		p.hp_states.MEDIUM:
			match randi_range(1,3):
				1,2: current_state = states.AGGRESSIVE
				3: current_state = states.DEFENSIVE
		p.hp_states.LOW:
			match randi_range(1,5):
				1,2,3,4: current_state = states.DEFENSIVE
				5: current_state = states.AGGRESSIVE

func _move_toward() -> void:
	if p.distance_from_opponent.x > 0:
		grid_limit_component.move_x(1)
	elif p.distance_from_opponent.x < 0:
		grid_limit_component.move_x(-1)
	
	if p.distance_from_opponent.y > 0:
		grid_limit_component.move_y(1)
	elif p.distance_from_opponent.y < 0:
		grid_limit_component.move_y(-1)

func _move_away() -> void:
	if randf() > 0.1:
		if p.distance_from_opponent.x > 0:
			grid_limit_component.move_x(1)
		elif p.distance_from_opponent.x < 0:
			grid_limit_component.move_x(-1)
	else:
		if randf() > 0.5:
			grid_limit_component.move_x(1)
		else:
			grid_limit_component.move_x(-1)
	
	if randf() > 0.1:
		if p.distance_from_opponent.y > 0:
			grid_limit_component.move_y(-1)
		elif p.distance_from_opponent.y < 0:
			grid_limit_component.move_y(1)
	else:
		if randf() > 0.5:
			grid_limit_component.move_y(1)
		else:
			grid_limit_component.move_y(-1)
