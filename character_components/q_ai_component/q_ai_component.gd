extends Node2D
## JOHN AI LMAOOOO
## IM GOING FUCKING INSANE
class_name QAIComponent

@onready var p : Character = get_parent()

@export var grid_limit_component : GridLimitComponent

var q_matrix : QMatrix
var reward: float
var points: float
var opponent : Character = Global.player_2
var game_state_code : Array[int] = [
	0, # HP (0 1 2) [0]
	0, # Enemy HP (0 1 2) [1]
	0, # Distance (0 1 2) [2]
	0, # Energy (0 1) [3]
]

const reward_rules : Dictionary = { ## Contains the rewards for each event that happens for the Q AI
	"damage_enemy": 1.0,
	"take_damage": -1.0,
	"win": 10.0,
	"lose": -10.0,
	"miss": -0.5,
}

## number between 0 and 1 (e.g., 0.1 means 10% exploration, 90% exploitation).
## at each step, generates random number
## if random_num < e; choose random/exploit
## if random_num > e; choose best/exploit
const epsilon_greedy : float = 0.1

## gamma / discount rate
const gamma_discount_rate : float = 0.8

func _init() -> void:
	# Signal connections
	# The events & stuff that could happen to the AI
	#GSignals.hit.connect(_hit)
	#GSignals.miss.connect(_miss)
	#GSignals.took_damage.connect(_took_damage)
	#GSignals.win.connect(_win)
	#GSignals.lose.connect(_lose)
	
	pass

func _ready() -> void:
	await get_tree().process_frame
	q_matrix = Global.q_matrix # Gets a reference to the Q Matrix
	
	if grid_limit_component.is_player_1:
		opponent = Global.player_2
	else:
		opponent = Global.player_1

func process_handle() -> void:
	_input_handles()

func hit(is_p1: bool,character:Character) -> void:
	if character.control_type != character.control_types.QL_AI:
		return
	
	reward = reward_rules["damage_enemy"]
	Global.points += reward

func miss(is_p1:bool, character:Character) -> void:
	if character.control_type != character.control_types.QL_AI:
		return
	
	reward = reward_rules["miss"]
	Global.points += reward

func took_damage(is_p1:bool, character:Character) -> void:
	if character.control_type != character.control_types.QL_AI:
		return
	
	reward = reward_rules["take_damage"]
	Global.points += reward

func win(is_p1:bool, character:Character) -> void:
	if character.control_type != character.control_types.QL_AI:
		return
	
	reward = reward_rules["win"]
	Global.points += reward

func lose(is_p1:bool, character:Character) -> void:
	if character.control_type != character.control_types.QL_AI:
		return
	
	reward = reward_rules["lose"]
	Global.points += reward

func _process(delta: float) -> void:
	#%points.text = str(Global.points)
	#%points.text = str(p.distance_from_opponent.length())
	#%points.text = str(p.get_distance_state())
	
	game_state_code[0] = p.get_hp_state()
	game_state_code[1] = opponent.get_hp_state()
	game_state_code[2] = p.get_distance_state()
	game_state_code[3] = p.get_energy_state()
	
	q_matrix.game_state_code = game_state_code
	
	#%points.text = str( # HP, ENEMY HP, DISTANCE, ENERGY
		#p.get_hp_state(),
		#opponent.get_hp_state(),
		#p.get_distance_state(),
		#p.get_energy_state()
	#)
	
	%points.text = str(game_state_code)

func _input_handles() -> void:
	
	if (
			Input.is_action_just_pressed("end_turn") and 
			Global.current_turn == p and 
			p.allow_end_turn
			):
		if p == Global.player_1:
			Global.current_turn = Global.player_2
			Global.turn_changed.emit(Global.player_2)
		elif p == Global.player_2:
			Global.current_turn = Global.player_1
			Global.turn_changed.emit(Global.player_1)
	
	if p.energy <= 0:
		# Disallows moving and attacking when you ran out of energy
		return
	
	if Input.is_action_just_pressed("right"):
		grid_limit_component.move_x(1)
	if Input.is_action_just_pressed("left"):
		grid_limit_component.move_x(-1)
	if Input.is_action_just_pressed("up"):
		grid_limit_component.move_y(-1)
	if Input.is_action_just_pressed("down"):
		grid_limit_component.move_y(1)
	
	if (
			Input.is_action_just_pressed("attack") and
			p.allow_attack
		):
		p.attacked()
