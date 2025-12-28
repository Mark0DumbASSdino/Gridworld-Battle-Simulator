extends Node2D
## Component that accounts for grid limits
## Stops the characters from going beyond the grid bounds
## when moving and stuff
class_name GridLimitComponent

@onready var p : Character = get_parent()

func move_x(amount: int) -> void:
	if amount <= 0: # Going to left / negative
		if (p.grid_pos.x + amount) < Global.grid_bounds_top_left.x: # Going beyond the left bound
			pass
		else:
			p.grid_pos.x += amount
			p.moved()
	
	if amount >= 0: # Going to right / positive
		if (p.grid_pos.x + amount) > Global.grid_bounds_bot_right.x: # Going beyond the right bound
			pass
		else:
			p.grid_pos.x += amount
			p.moved()

func move_y(amount: int) -> void:
	if amount <= 0: # Going to up / negative
		if (p.grid_pos.y + amount) < Global.grid_bounds_top_left.y: # Going beyond the top bound
			pass
		else:
			p.grid_pos.y += amount
			p.moved()
	
	if amount >= 0: # Going to bottom / positive
		if (p.grid_pos.y + amount) > Global.grid_bounds_bot_right.y: # Going beyond the bottom bound
			pass
		else:
			p.grid_pos.y += amount
			p.moved()
