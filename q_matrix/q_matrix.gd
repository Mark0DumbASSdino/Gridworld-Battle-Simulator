extends Control
## OPENAI IM COMING FOR YOUR ASS
## THIS WILL BE SUPRE ADVANCED AI
## THAT CAN MAKE SUPER POOP JOKES
## AT LIGHT SPEED AND CONSUME
## 5 QUADRILLION GALLONS OF WATER PER NANOSECOND
## AND USE UP 67 ZILLIONS TERAWATTS OF POWER
## AND USE UP LIKE FUCKING 8 BILLION DOLLARS WORTH OF RAM
## CONSEQUENTLY DESTROYING THE FUCKING PLANET
class_name QMatrix

@onready var rows: VBoxContainer = %rows

var game_state_row_scn : PackedScene = preload("res://q_matrix/game_state_row/game_state_row.tscn")

func _ready() -> void:
	Global.q_matrix = self
	
	for n in 54:
		_create_game_state_row(n)

## Instantiates/Creates all 54 game state rows
## from 0000 to 2221
func _create_game_state_row(index: int) -> void:
	var game_state_row : GameStateRow = game_state_row_scn.instantiate()
	game_state_row.index = index
	rows.add_child(game_state_row)

var old_q_value : float

func _get_new_q_value(state: Array[int], action: Global.actions) -> float: ## The new Q-Value
	
	old_q_value
	
	return 0.1

var ref_gsr_posy: float
func _process(delta: float) -> void:
	ref_gsr_posy = Global.test_game_state_row.global_position.y
	%arrow.global_position.y = ref_gsr_posy
