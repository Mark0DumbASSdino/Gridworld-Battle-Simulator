extends CanvasLayer

var time : float

func _process(delta: float) -> void:
	time = wrapf(time + delta, 0, 180)
	
	%stats.global_position.y = (
		960 + (sin(time) * 10)
	)
	%who_turn.global_position.y = (
		850 + (sin(time) * 10)
	)
	
