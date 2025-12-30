extends Node
## An autoload global singleton
## that has the signals
## for events that could happen in the game
## that the Q Learning AI thingy needs to know
class_name Signals

signal hit(is_p1:bool, character:Character)
signal miss(is_p1:bool, character:Character)
signal took_damage(is_p1:bool, character:Character)
signal win(is_p1:bool, character:Character)
signal lose(is_p1:bool, character:Character)

func _init() -> void:
	# Signal connections
	hit.connect(_hit)
	miss.connect(_miss)
	took_damage.connect(_took_damage)
	win.connect(_win)
	lose.connect(_lose)

func _hit(is_p1: bool,character:Character) -> void:
	#print(
	#	get_p1_str(is_p1) + " dealt damage to " + get_p1_str(!is_p1)
	#	)
	
	pass

func _miss(is_p1:bool, character:Character) -> void:
	#print(
	#	get_p1_str(is_p1) + " throwing straight airballs lmao lol"
	#	)
	
	pass

func _took_damage(is_p1:bool, character:Character) -> void:
	#print(
		#get_p1_str(is_p1) + " took damage from " + get_p1_str(!is_p1)
		#)
	
	pass

func _win(is_p1:bool, character:Character) -> void:
	#print(
		#get_p1_str(is_p1) + " won against " + get_p1_str(!is_p1)
		#)
	
	if is_p1:
		Global.p1_wins += 1
	else:
		Global.p2_wins += 1
	
	pass

func _lose(is_p1:bool, character:Character) -> void:
	#print(
		#get_p1_str(is_p1) + " lost against " + get_p1_str(!is_p1)
		#)
	
	pass

func get_p1_str(is_p1: bool) -> String:
	if is_p1:
		return "P1"
	else:
		return "P2"
