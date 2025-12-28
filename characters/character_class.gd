extends Node2D
## Parent class for characters
class_name Character

@export var start_pos : Vector2
@export var max_hp : int
var hp : int
@export var max_energy : int
var energy : int
@export var ai : bool = false

var grid_pos : Vector2
