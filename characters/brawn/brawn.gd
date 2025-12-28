extends Character
## Brawny (Basic Tanky Brawler)
## 20 HP, 3 Energy
## Ts finna be the only character
## Cuz having 3 characters AND the q learning rl system thingy
## Would make me wanna shoot myself /j
## fr tho
class_name Brawn

@onready var anim: AnimationPlayer = %anim
@onready var player_component: PlayerComponent = %player_component

var desired_pos : Vector2

const pos_lerp_weight : float = 20

func _ready() -> void:
	grid_pos = start_pos
	hp = max_hp
	energy = max_energy

func _process(delta: float) -> void:
	
	desired_pos = grid_pos * Global.tile_size
	
	global_position = global_position.lerp(
		desired_pos, 
		pos_lerp_weight * delta
		)
	
	if control_type == control_types.PLAYER:
		player_component.move_handle_player()

func moved() -> void:
	energy -= 1
