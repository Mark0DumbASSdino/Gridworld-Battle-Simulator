extends Node2D
## Main game scene
## Where the combat & shit happens
class_name Game

var someone_won : bool = false
var arrow_desired_pos : Vector2

func _init() -> void:
	# Signal connections
	Global.win.connect(_win)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://screens/start/start.tscn")
	
	if (
		Input.is_action_just_pressed("restart") and 
		someone_won
		):
		get_tree().reload_current_scene()

func _process(delta: float) -> void:
	if Global.current_turn:
		arrow_desired_pos = (
			Global.current_turn.global_position + 
			Vector2(16, -60)
		)
	
	%arrow.global_position = %arrow.global_position.lerp(
		arrow_desired_pos, 12 * delta
	)

func _win(winning_char: Character) -> void:
	print(winning_char.name, " Wins!")
	someone_won = true
