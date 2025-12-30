extends HBoxContainer
class_name GameStateRow

var index : int = 0

var game_state : Array[int] = [
	0, # HP (0 1 2) [0]
	0, # Enemy HP (0 1 2) [1]
	0, # Distance (0 1 2) [2]
	0, # Energy (0 1) [3]
]

func _ready() -> void:
	for n in index:
		game_state[3] += 1
		
		if game_state[3] >= 2:
			
			game_state[3] = 0
			game_state[2] += 1
			
			if game_state[2] >= 3:
				
				game_state[2] = 0
				game_state[1] += 1
				
				if game_state[1] >= 3:
					
					game_state[1] = 0
					game_state[0] += 1
					
	
	if index == 50:
		Global.test_game_state_row = self
	
	%gs_txt.text = str(
		game_state[0],
		game_state[1],
		game_state[2],
		game_state[3],
	)
