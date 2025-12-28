extends VBoxContainer

func _process(_delta: float) -> void:
	
	%p1_hp.text = str(
		"P1 hp:  ",
		Global.player_1.hp,
		"/",
		Global.player_1.max_hp
	)
	
	%p2_hp.text = str(
		"P2 hp:  ",
		Global.player_2.hp,
		"/",
		Global.player_2.max_hp
	)
