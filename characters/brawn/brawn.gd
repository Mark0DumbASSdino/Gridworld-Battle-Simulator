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
@onready var scripted_ai_component: ScriptedAIComponent = %scripted_ai_component
@onready var grid_limit_component: GridLimitComponent = %grid_limit_component
@onready var q_ai_component: QAIComponent = %q_ai_component
@onready var hitboxes : Array[CollisionShape2D] = [
	%hibc, %hibc2, %hibc3, %hibc4
]

var desired_pos : Vector2
var enable_hitbox : bool = false
var allow_end_turn : bool = true
var allow_attack : bool = true
var allow_move : bool = true
var attack_landed : bool = false

const pos_lerp_weight : float = 20

func _ready() -> void:
	Engine.time_scale = 1.5
	
	grid_pos = start_pos
	hp = max_hp
	energy = max_energy
	
	# Signal Connections
	%hitbox.area_entered.connect(_hitbox_enter)
	%hurtbox.area_entered.connect(_hurtbox_enter)
	Global.turn_changed.connect(my_turn_started)
	
	%q_ai_component.process_mode = Node.PROCESS_MODE_DISABLED
	if control_type == control_types.QL_AI:
		%q_ai_component.process_mode = Node.PROCESS_MODE_INHERIT

func _process(delta: float) -> void:
	
	desired_pos = grid_pos * Global.tile_size
	
	global_position = global_position.lerp(
		desired_pos, 
		pos_lerp_weight * delta
		)
	
	for hitbox in hitboxes:
		hitbox.disabled = not enable_hitbox
	
	#%Label.text = str(get_hp_state(), get_energy_state())
	%Label.text = str(Global.get_hp_difference())
	
	if hp <= 0:
		Global.someone_won = true
		Global.current_turn = null
		if grid_limit_component.is_player_1:
			Global.winning_character = Global.player_2
		else:
			Global.winning_character = Global.player_1
	
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
	elif control_type == control_types.QL_AI:
		q_ai_component.process_handle()

func moved() -> void:
	energy -= 1
	anim.stop()
	anim.play("move")
	
	%move.pitch_scale = randf_range(1.8, 2.2)
	%move.play()
	
	allow_move = false
	await get_tree().create_timer(0.15).timeout
	allow_move = true

func attacked() -> void:
	
	energy -= 1
	anim.stop()
	anim.play("attack")
	
	%slash.pitch_scale = randf_range(0.8, 1.2)
	%slash.play()
	
	attack_landed = false
	
	allow_attack = false
	
	enable_hitbox = true
	await get_tree().create_timer(0.1).timeout
	enable_hitbox = false
	
	await get_tree().create_timer(0.05).timeout
	allow_attack = true
	
	if attack_landed:
		GSignals.hit.emit(grid_limit_component.is_player_1, self)
		q_ai_component.hit(grid_limit_component.is_player_1, self)
	else:
		GSignals.miss.emit(grid_limit_component.is_player_1, self)
		q_ai_component.miss(grid_limit_component.is_player_1, self)

func _hitbox_enter(area: Area2D) -> void:
	if area.name == "hurtbox" and area.get_parent() is Character:
		
		attack_landed = true
		
		if area.get_parent().hp <= 0:
			
			GSignals.win.emit(grid_limit_component.is_player_1, self)
			q_ai_component.win(grid_limit_component.is_player_1, self)
			
			Global.win.emit(self)

func _hurtbox_enter(area: Area2D) -> void:
	if area.name == "hitbox":
		# Taking damage
		%hit.pitch_scale = randf_range(0.8, 1.2)
		%hit.play()
		
		if grid_limit_component.is_player_1: # Check if it's P1 taking the damage
			
			if Global.get_hp_difference() > 0: # If P1 has hp advantage
				# P1 has more health but is taking damage from P2, so it should have more chance 
				# of taking crit damage
				if randf() < 0.6:
					# 60% chance of taking crit
					hp -= 2
				else:
					# 40% chance not to
					hp -= 1
				
			elif Global.get_hp_difference() < 0: # If P1 has lesser hp/hp disadvantage
				# P1 has less health but is taking damage from P2, so it should have less chance
				# of taking crit damage
				if randf() < 0.1:
					# 10% chance of taking crit
					hp -= 2
				else:
					# 90% chance not to
					hp -= 1
			
			elif Global.get_hp_difference() == 0: # Noone has advantage
				if randf() < 0.1:
					# 20% chance of taking crit
					hp -= 2
				else:
					# 80% chance not to
					hp -= 1
		
		
		else: # Now it's P2 taking damage
			if Global.get_hp_difference() < 0: # If P2 has hp advantage
				# P2 has more health but is taking damage from P1, so it should have more chance 
				# of taking crit damage
				if randf() < 0.6:
					# 60% chance of taking crit
					hp -= 2
				else:
					# 40% chance not to
					hp -= 1
				
			elif Global.get_hp_difference() > 0: # If P2 has lesser hp/hp disadvantage
				# P2 has less health but is taking damage from P1, so it should have less chance
				# of taking crit damage
				if randf() < 0.1:
					# 10% chance of taking crit
					hp -= 2
				else:
					# 90% chance not to
					hp -= 1
			
			elif Global.get_hp_difference() == 0: # Noone has advantage
				if randf() < 0.1:
					# 20% chance of taking crit
					hp -= 2
				else:
					# 80% chance not to
					hp -= 1
		
		
		GSignals.took_damage.emit(grid_limit_component.is_player_1, self)
		q_ai_component.took_damage(grid_limit_component.is_player_1, self)
		
		if hp <= 0:
			
			GSignals.lose.emit(grid_limit_component.is_player_1, self)
			q_ai_component.lose(grid_limit_component.is_player_1, self)
			
			Global.current_turn = null

func my_turn_started(_to_who: Character) -> void:
	energy = max_energy
	
	allow_end_turn = false
	await get_tree().process_frame
	allow_end_turn = true
