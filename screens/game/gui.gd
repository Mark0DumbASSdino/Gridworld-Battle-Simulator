extends CanvasLayer

var time : float

func _init() -> void:
	# Signal connections
	#Global.win.connect(_win)
	pass

func _ready() -> void:
	%win.hide()

func _process(delta: float) -> void:
	
	time = wrapf(time + delta, 0, 180)
	
	%stats.global_position.y = (
		960 + (sin(time) * 10)
	)
	%who_turn.global_position.y = (
		750 + (sin(time) * 10)
	)
	
	%wins.text = str(Global.p1_wins," | ", Global.p2_wins)
	
	if Global.someone_won and Global.winning_character:
		%win.show()
		%win.text = str(
			Global.winning_character.name, " Wins! \n",
			"Press R to Restart"
		)
	else:
		%win.hide()

#func _win(winning_char: Character) -> void:
