extends Node2D
## Component that gets activated when the 
## control type is player
## All its inputs and stuff handled here, move and attack
class_name PlayerComponent

@onready var p : Character = get_parent()

@export var grid_limit_component : GridLimitComponent

var allow_attack : bool = true

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
			allow_attack
		):
		p.attacked()
		p.enable_hitbox = true
		allow_attack = false
		await get_tree().create_timer(0.1).timeout
		p.enable_hitbox = false
		allow_attack = true
