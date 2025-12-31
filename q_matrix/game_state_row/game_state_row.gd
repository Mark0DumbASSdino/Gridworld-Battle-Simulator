extends HBoxContainer
class_name GameStateRow

var q_matrix : QMatrix
var index : int = 0
var my_game_state : Array[int] = [
	0, # HP (0 1 2) [0]
	0, # Enemy HP (0 1 2) [1]
	0, # Distance (0 1 2) [2]
	0, # Energy (0 1) [3]
]
var game_state_code : Array[int]

func _ready() -> void:
	for n in index:
		my_game_state[3] += 1
		
		if my_game_state[3] >= 2:
			
			my_game_state[3] = 0
			my_game_state[2] += 1
			
			if my_game_state[2] >= 3:
				
				my_game_state[2] = 0
				my_game_state[1] += 1
				
				if my_game_state[1] >= 3:
					
					my_game_state[1] = 0
					my_game_state[0] += 1
					
	
	%gs_txt.text = str(
		my_game_state[0],
		my_game_state[1],
		my_game_state[2],
		my_game_state[3],
	)

func _process(delta: float) -> void:
	game_state_code = q_matrix.game_state_code
	
	if game_state_code == my_game_state:
		Global.current_game_state_row = self
