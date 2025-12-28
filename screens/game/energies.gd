extends VBoxContainer

func _process(delta: float) -> void:
	%p1_energy.text = str(
		"Player 1:  ",
		Global.player_1.energy,
		"/",
		Global.player_1.max_energy
	)
	
	%p2_energy.text = str(
		"Player 2:  ",
		Global.player_2.energy,
		"/",
		Global.player_2.max_energy
	)
