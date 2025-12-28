extends VBoxContainer
class_name WhoTurn

func _process(_delta: float) -> void:
	%turn.text = str("Current turn: \n", Global.current_turn.name)
