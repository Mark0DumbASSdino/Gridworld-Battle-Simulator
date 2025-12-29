extends Character
## Brawny (Basic Tanky Brawler)
## 20 HP, 3 Energy
## Ts finna be the only character
## Cuz having 3 characters AND the q learning rl system thingy
## Would make me wanna shoot myself /j4
## fr tho
class_name Brawn

@onready var anim: AnimationPlayer = %anim
@onready var player_component: PlayerComponent = %player_component
@onready var scripted_ai_component: ScriptedAIComponent = %scripted_ai_component
@onready var grid_limit_component: GridLimitComponent = %grid_limit_component
@onready var hitboxes : Array[CollisionShape2D] = [
	%hibc, %hibc2, %hibc3, %hibc4
]

var desired_pos : Vector2
var enable_hitbox : bool = false
var allow_end_turn : bool = true
var allow_attack : bool = true
var allow_move : bool = true

const pos_lerp_weight : float = 20

func _ready() -> void:
	grid_pos = start_pos
	hp = max_hp
	energy = max_energy
	
	# Signal Connections
	%hitbox.area_entered.connect(_hitbox_enter)
	%hurtbox.area_entered.connect(_hurtbox_enter)
	Global.turn_changed.connect(my_turn_started)

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
		player_component.end_turn_handle_player()
	elif control_type == control_types.SCRIPTED_AI:
		scripted_ai_component.move_handle_script_ai()
		scripted_ai_component.attack_handle_script_ai()
		scripted_ai_component.end_turn_handle_scripted_ai()

func moved() -> void:
	energy -= 1
	anim.stop()
	anim.play("move")
	
	allow_move = false
	await get_tree().create_timer(0.1).timeout
	allow_move = true

func attacked() -> void:
	energy -= 1
	anim.stop()
	anim.play("attack")

	enable_hitbox = true
	allow_attack = false
	await get_tree().create_timer(0.1).timeout
	enable_hitbox = false
	allow_attack = true

func _hitbox_enter(area: Area2D) -> void:
	if area.name == "hurtbox" and area.get_parent() is Character:
		
		GSignals.hit.emit(grid_limit_component.is_player_1, self)
		
		if area.get_parent().hp <= 0:
			
			GSignals.win.emit(grid_limit_component.is_player_1, self)
			
			Global.win.emit(self)

func _hurtbox_enter(area: Area2D) -> void:
	if area.name == "hitbox":
		# Taking damage
		hp -= 1
		
		GSignals.took_damage.emit(grid_limit_component.is_player_1, self)
		
		if hp <= 0:
			
			GSignals.lose.emit(grid_limit_component.is_player_1, self)
			
			Global.current_turn = null

func my_turn_started(_to_who: Character) -> void:
	energy = max_energy
	
	allow_end_turn = false
	await get_tree().process_frame
	allow_end_turn = true
