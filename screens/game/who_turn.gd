extends VBoxContainer
class_name WhoTurn

func _process(_delta: float) -> void:
	if Global.current_turn:
		%turn.text = str("Current turn: \n", Global.current_turn.name)
	else:
		%turn.text = str("Win")
