extends Node2D
## Parent class for characters
class_name Character

enum control_types {
	PLAYER, SCRIPTED_AI, QL_AI
}

@export var start_pos : Vector2

@export var max_hp : int = 20
var hp : int

@export var max_energy : int = 3
var energy : int

@export var control_type : control_types

var grid_pos : Vector2
