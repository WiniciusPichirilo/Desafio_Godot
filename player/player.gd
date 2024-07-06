extends CharacterBody2D
class_name Player

#======================================================================
@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sword_area : Area2D = $SwordArea
@onready var hitbox_area : Area2D = $HitboxArea
@onready var health_progress_bar : ProgressBar = $HealthProgressBar
@onready var ritual_progress_bar : ProgressBar = $RitualProgressBar

#======================================================================
@export_category("Movement")
@export var speed : float = 3.0

#@export_category("Sword")
#@export var sword_damage : int = 2
var sword_damage : int = 2

@export_category("Ritual")
#@export var ritual_damage : int = 1
@export var ritual_damage : Vector2i = Vector2i(1,8)
@export var ritual_interval : Vector2 = Vector2(12.0, 20.0)
@export var ritual_scene : PackedScene

@export_category("Life")
@export var health : int = 100
@export var max_health : int = 100
@export var death_prefab : PackedScene 

#======================================================================
var input_vector: Vector2 = Vector2.ZERO
var is_running : bool = false
var was_running : bool = false
var is_attacking: bool = false
var attack_cooldown: float = 0.0
var hitbox_cooldown: float = 0.0
var ritual_cooldown: float = 0.0
var ritual_cost: int = 10
var current_attack = 1
var attack_direction_vector: Vector2 = Vector2.RIGHT

#======================================================================
signal meat_collected(value : int)
signal gold_collected(value : int)

#======================================================================
func _ready() -> void:
	GameManager.player = self
	meat_collected.connect(func(): GameManager.meat_counter += 1)	
	gold_collected.connect(func(): GameManager.gold_counter += randi_range(1, 20))
	
#======================================================================
func _process(delta: float) -> void:
	GameManager.player_position = position
	#health = max_health	
	
	attack_direction_vector = attack_direction()
	
	if not is_attacking:
		read_input()		
	
	update_attack_cooldown(delta)	
	if Input.is_action_just_pressed("attack"):
		attack()		
			
	play_run_idle_animation()		
	
	if not is_attacking:
		rotate_sprite()
		
	update_hitbox_detection(delta)		
	update_ritual(delta)
	
	health_progress_bar.max_value = max_health
	health_progress_bar.value = health
		
#======================================================================
func _physics_process(delta: float) -> void:	
	var target_velocity = input_vector * speed * 100
	if is_attacking:
		target_velocity *= 0.25
	velocity = lerp(velocity, target_velocity, 0.1)
	move_and_slide()

#======================================================================
func read_input() -> void:
	input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down") #, 0.15)
		
	var deadzone = 0.15
	if abs(input_vector.x) < deadzone:
		input_vector.x = 0
	if abs(input_vector.y) < deadzone:
		input_vector.y = 0			
		
	was_running = is_running
	is_running = not input_vector.is_zero_approx()

#======================================================================
func update_attack_cooldown(delta: float)-> void:
	if is_attacking:
		attack_cooldown -= delta
		if attack_cooldown <= 0:
			is_attacking = false
			is_running = false
			animation_player.play("idle")

#======================================================================
func update_ritual(delta: float)-> void:
	ritual_cooldown -= delta
	ritual_progress_bar.value = ritual_progress_bar.max_value - ritual_cooldown
	if ritual_cooldown > 0:
		return
	if GameManager.gold_counter < ritual_cost:
		return
	ritual_cooldown = randf_range(ritual_interval.x, ritual_interval.y)
	var ritual = ritual_scene.instantiate()
	ritual.damage_amount_range = ritual_damage
	GameManager.gold_counter -= ritual_cost
	add_child(ritual)
	
#======================================================================
func play_run_idle_animation() -> void:
	if not is_attacking:
		if was_running != is_running:
			if is_running:
				animation_player.play("run")
			else: 
				animation_player.play("idle")	

#======================================================================
func rotate_sprite() -> void:
	if input_vector.x > 0:
		sprite.flip_h = false
	elif input_vector.x < 0:
		sprite.flip_h = true	

#======================================================================
func attack() -> void:
	if is_attacking:
		return
	
	#var direction = attack_direction()
	if attack_direction_vector == Vector2.DOWN:
		animation_player.play("attack_down_" + str(current_attack%2+1))
	elif attack_direction_vector == Vector2.UP:
		animation_player.play("attack_up_" + str(current_attack%2+1))
	else:
		animation_player.play("attack_side_" + str(current_attack%2+1))
	
	current_attack += 1
		
	attack_cooldown = 0.55
	is_attacking = true
	
	#deal_damage_to_enemies()

#======================================================================
func attack_direction() -> Vector2:
	var direction : Vector2 = Vector2.ZERO
	var attack_angle = rad_to_deg(input_vector.angle())
	var attack_horizontal = abs(attack_angle)
	
	if attack_horizontal <= 45 or attack_horizontal >= 135:
		if sprite.flip_h:
			direction = Vector2.LEFT
		else:
			direction = Vector2.RIGHT
	elif attack_angle > 45 and attack_angle < 135:
		direction = Vector2.DOWN
	else:
		direction = Vector2.UP
	return direction
		
#======================================================================
func deal_damage_to_enemies() ->void:
	var bodies = sword_area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies"):
			#var enemy : Enemy = body
			#enemy.damage(sword_damage)
			var direction_to_enemy = (body.position - position).normalized()
			
			#var attack_direction = attack_direction()
			var dot_product = direction_to_enemy.dot(attack_direction_vector) 
			#var dot_product = input_vector.dot(direction_to_enemy)
			if dot_product > 0: #0.3:
				sword_damage = randi_range(1,5)
				body.damage(sword_damage)			
	
#======================================================================
func update_hitbox_detection(delta: float) -> void:
	hitbox_cooldown -= delta
	if hitbox_cooldown > 0:
		return
		
	hitbox_cooldown = 0.5
		
	var bodies = hitbox_area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies"):
			var damage_amount = body.attack_power
			damage(damage_amount)

#======================================================================
func damage(amount: int) -> void:
	if health <= 0:
		return
		
	health -= amount
	#print("Player recebeu dano de ", amount, ". A vida total é ", health, "/", max_health)
	
	sprite.modulate = Color.RED
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(sprite, "modulate", Color.WHITE, 0.3)
	
	if health <= 0:
		die()
		
#======================================================================
func die() -> void:
	GameManager.end_game()
	
	if death_prefab:
		var death_object = death_prefab.instantiate()
		death_object.position = position
		get_parent().add_child(death_object)
	
	queue_free()	
	
#======================================================================
func heal(amount: int) -> int:
	health += amount
	if health > max_health:
		health = max_health
	#print("Player recebeu cura de ", amount, ". A vida total é ", health, "/", max_health)
	return health
