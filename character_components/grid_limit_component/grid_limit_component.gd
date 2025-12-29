extends Node2D
## Component that accounts for grid limits
## Stops the characters from going beyond the grid bounds
## when moving and stuff
## also to disallow the 2 characters from going to the same tile
class_name GridLimitComponent

@onready var p : Character = get_parent()

var is_player_1 : bool = false ## If true, then the parent Character is P1. If false, the parent Character is P2

func _ready() -> void:
	await get_tree().process_frame
	is_player_1 = p == Global.player_1

func move_x(amount: int) -> void:
	if not p.allow_move:
		return
	
	if amount <= 0: # Going to left / negative
		if (p.grid_pos.x + amount) < Global.grid_bounds_top_left.x: # Going beyond the left bound:
			pass
		else:
			collision_with_other_player_check(-1, 0)
		
		
	
	if amount >= 0: # Going to right / positive
		if (p.grid_pos.x + amount) > Global.grid_bounds_bot_right.x: # Going beyond the right bound
			pass
		else:
			collision_with_other_player_check(1, 0)
		
		
	

func move_y(amount: int) -> void:
	if not p.allow_move:
		return
	
	if amount <= 0: # Going to up / negative
		if (p.grid_pos.y + amount) < Global.grid_bounds_top_left.y: # Going beyond the top bound
			pass
		else:
			collision_with_other_player_check(0, -1)
		
		
	
	if amount >= 0: # Going to bottom / positive
		if (p.grid_pos.y + amount) > Global.grid_bounds_bot_right.y: # Going beyond the bottom bound
			pass
		else:
			collision_with_other_player_check(0, 1)
		
		
	

func collision_with_other_player_check(amount_x: int, amount_y: int) -> void: ## Final check before deciding to move or nah
	var grid_pos_after_move : Vector2 = Vector2(
		p.grid_pos.x + amount_x, p.grid_pos.y + amount_y
	)
	
	if is_player_1:
		if grid_pos_after_move == Global.player_2.grid_pos:
			pass
		else:
			p.grid_pos = grid_pos_after_move
			p.moved()
	else:
		if grid_pos_after_move == Global.player_1.grid_pos:
			pass
		else:
			p.grid_pos = grid_pos_after_move
			p.moved()

func _process(_delta: float) -> void:
	if is_player_1:
		p.distance_from_opponent = Global.player_2.grid_pos - p.grid_pos
	else:
		p.distance_from_opponent = Global.player_1.grid_pos - p.grid_pos
	
	#%Label.text = str(p.distance_from_opponent, " : ", p.distance_from_opponent.length())
