extends VBoxContainer

func _process(_delta: float) -> void:
	
	%p1_energy.text = str(
		"| energy:  ",
		Global.player_1.energy,
		"/",
		Global.player_1.max_energy
	)
	
	%p2_energy.text = str(
		"| energy:  ",
		Global.player_2.energy,
		"/",
		Global.player_2.max_energy
	)
