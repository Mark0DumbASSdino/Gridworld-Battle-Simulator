extends Node2D
## Parent class for characters
class_name Character

enum control_types {
	PLAYER, SCRIPTED_AI, QL_AI
}

@export var start_pos : Vector2

@export var max_hp : int = 20
var hp : int
enum hp_states {
	HIGH, MEDIUM, LOW
}
var hp_state : hp_states

@export var max_energy : int = 3
var energy : int
enum energy_states {
	HIGH, MEDIUM, LOW
}
var energy_state : energy_states

@export var control_type : control_types

var grid_pos : Vector2
var distance_from_opponent : Vector2

func get_hp_state() -> hp_states:
	var hp_ratio : float = float(hp) / float(max_hp)
	if hp_ratio > 0.66:
		return hp_states.HIGH
	
	elif hp_ratio >= 0.33 and hp_ratio <= 0.66:
		return hp_states.MEDIUM
		
	elif hp_ratio < 0.33:
		return hp_states.LOW
	
	else:
		return hp_states.LOW

func get_energy_state() -> energy_states:
	var energy_ratio : float = float(energy) / float(max_energy)
	if energy_ratio > 0.66:
		return energy_states.HIGH
	
	elif energy_ratio >= 0.33 and energy_ratio <= 0.66:
		return energy_states.MEDIUM
		
	elif energy_ratio < 0.33:
		return energy_states.LOW
	
	else:
		return energy_states.LOW
