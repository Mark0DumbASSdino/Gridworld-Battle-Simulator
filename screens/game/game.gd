extends Node2D
## Main game scene
## Where the combat & shit happens
class_name Game

var someone_won : bool = false
var arrow_desired_pos : Vector2

func _init() -> void:
	# Signal connections
	Global.win.connect(_win)

func _ready() -> void:
	someone_won = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://screens/start/start.tscn")

func _process(delta: float) -> void:
	if Global.current_turn:
		arrow_desired_pos = (
			Global.current_turn.global_position + 
			Vector2(16, -60)
		)
	
	%arrow.global_position = %arrow.global_position.lerp(
		arrow_desired_pos, 12 * delta
	)

	if (
		Global.player_1.control_type == Global.player_1.control_types.PLAYER or
		Global.player_2.control_type == Global.player_2.control_types.PLAYER
		):
		if (
			Input.is_action_just_pressed("restart") and 
			someone_won
			):
			get_tree().reload_current_scene()
	else:
		if (
			someone_won
			):
			await get_tree().create_timer(0.1).timeout
			get_tree().reload_current_scene()

func _win(winning_char: Character) -> void:
	#print(winning_char.name, " Wins!")
	someone_won = true
