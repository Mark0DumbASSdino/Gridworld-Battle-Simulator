extends Node2D
## JOHN AI LMAOOOO
## IM GOING FUCKING INSANE
class_name QAIComponent

@onready var p : Character = get_parent()

@export var grid_limit_component : GridLimitComponent

var points : float = 0
var reward : float = 0
var q_matrix : QMatrix

const reward_rules : Dictionary = { ## Contains the rewards for each event that happens for the Q AI
	"damage_enemy": 1.0,
	"take_damage": -1.0,
	"win": 10.0,
	"lose": -10.0,
	"miss": -0.5,
}

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

func process_handle() -> void:
	_input_handles()

func hit(is_p1: bool,character:Character) -> void:
	
	reward = reward_rules["damage_enemy"]
	points += reward

func miss(is_p1:bool, character:Character) -> void:
	
	pass

func took_damage(is_p1:bool, character:Character) -> void:
	
	pass

func win(is_p1:bool, character:Character) -> void:
	
	pass

func lose(is_p1:bool, character:Character) -> void:
	
	pass

func _process(delta: float) -> void:
	%points.text = str(points)

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
