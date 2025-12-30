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

func _create_game_state_row(index: int) -> void:
	var game_state_row : GameStateRow = game_state_row_scn.instantiate()
	game_state_row.index = index
	rows.add_child(game_state_row)
