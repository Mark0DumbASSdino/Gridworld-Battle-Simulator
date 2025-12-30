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
	LOW, MEDIUM, HIGH
}
var hp_state : hp_states

@export var max_energy : int = 3
var energy : int
enum energy_states {
	LOW, HIGH
}
var energy_state : energy_states

@export var control_type : control_types

var grid_pos : Vector2

var distance_from_opponent : Vector2
enum distance_states {
	LOW, MEDIUM, HIGH
}

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
	if energy_ratio > 0.5:
		return energy_states.HIGH
	
	elif energy_ratio <= 0.5:
		return energy_states.LOW
	
	else:
		return energy_states.LOW

func get_distance_state() -> distance_states:
	var distance : float = distance_from_opponent.length()
	if distance <= 1:
		return distance_states.LOW
		
	elif distance > 1 and distance <= 3:
		return distance_states.MEDIUM
		
	elif distance > 3:
		return distance_states.HIGH
		
	else:
		return distance_states.HIGH
