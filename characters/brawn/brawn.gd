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
@onready var hitboxes : Array[CollisionShape2D] = [
	%hibc, %hibc2, %hibc3, %hibc4
]

var desired_pos : Vector2
var enable_hitbox : bool = false

const pos_lerp_weight : float = 20

func _ready() -> void:
	grid_pos = start_pos
	hp = max_hp
	energy = max_energy
	
	# Signal Connections
	%hitbox.area_entered.connect(_hitbox_enter)
	%hurtbox.area_entered.connect(_hurtbox_enter)

func _process(delta: float) -> void:
	
	desired_pos = grid_pos * Global.tile_size
	
	global_position = global_position.lerp(
		desired_pos, 
		pos_lerp_weight * delta
		)
	
	for hitbox in hitboxes:
		hitbox.disabled = not enable_hitbox
	
	if Global.current_turn != self:
		# If it ain't yo turn, you can't do stuff
		return
	
	if control_type == control_types.PLAYER:
		player_component.move_handle_player()
		player_component.attack_handle_player()

func moved() -> void:
	energy -= 1
	anim.stop()
	anim.play("move")

func attacked() -> void:
	energy -= 1
	anim.stop()
	anim.play("attack")

func _hitbox_enter(area: Area2D) -> void:
	if area.name == "hurtbox":
		pass

func _hurtbox_enter(area: Area2D) -> void:
	if area.name == "hitbox":
		# Taking damage
		hp -= 1
