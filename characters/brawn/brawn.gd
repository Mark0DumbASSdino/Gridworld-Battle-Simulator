extends Character
## Brawny (Basic Tanky Brawler)
## 20 HP, 2 Move Points, 1 Action Point
## Passive(Tough Guy)- Every 4th hit he takes will deal 0 damage.
## Attack(Mega Punch)- Deals 6 damage, knocks the enemy back by two blocks
## Ability(Brave Jump)- Jumps to a location that is up to 2 blocks away, then slams down to deal 3 dmg in a 3x3 area.
class_name Brawn

func _ready() -> void:
	grid_pos = start_pos

func _process(_delta: float) -> void:
	
	global_position = grid_pos * 32
	
	if !ai:
		_move_handle()

func _move_handle() -> void:
	if Input.is_action_just_pressed("right"):
		grid_pos.x +=1
	if Input.is_action_just_pressed("left"):
		grid_pos.x -=1
	if Input.is_action_just_pressed("up"):
		grid_pos.y -=1
	if Input.is_action_just_pressed("down"):
		grid_pos.y +=1
