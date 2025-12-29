extends CanvasLayer

var time : float

func _init() -> void:
	# Signal connections
	Global.win.connect(_win)

func _ready() -> void:
	%win.hide()

func _process(delta: float) -> void:
	time = wrapf(time + delta, 0, 180)
	
	%stats.global_position.y = (
		960 + (sin(time) * 10)
	)
	%who_turn.global_position.y = (
		850 + (sin(time) * 10)
	)

func _win(winning_char: Character) -> void:
	%win.show()
	%win.text = str(
		winning_char.name, " Wins! \n",
		"Press R to Restart"
	)
