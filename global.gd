extends Node

var player_1 : Character
var player_2 : Character
var char_speed : float ## How fast the characters move / attack

var current_turn : Character ## Which character's turn it is

var q_matrix : QMatrix

var p1_wins : int
var p2_wins : int

const tile_size : int = 32
const grid_bounds_top_left : Vector2 = Vector2(
	-2, -1
	# -2, -1 if it's 6x4
)
const grid_bounds_bot_right : Vector2 = Vector2(
	3, 2
	# 3, 2 if it's 6x4
)

signal turn_changed(to_who: Character)
signal win(winning_character: Character)

func get_hp_difference() -> int:
	var hp_diff : int = (
		player_1.hp - player_2.hp
	)
	return hp_diff
