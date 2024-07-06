extends Node2D
class_name MobSpawner

#======================================================================
@export var creatures: Array[PackedScene]
#@export var mobs_per_minute: float = 60.0

#======================================================================
@onready var path_follow_2d: PathFollow2D = %PathFollow2D

#======================================================================
var cooldown: float = 0.0
var mobs_per_minute: float = 60.0

#======================================================================
func _process(delta: float) -> void:
	if GameManager.is_game_over:
		return
		
	if GameManager.current_monsters_on_gameplay >= GameManager.max_monsters_on_gameplay:
		return
			
	cooldown -= delta
	if cooldown > 0:
		return
		
	var interval = 60.0 / mobs_per_minute
	cooldown = interval
	
	var point = get_point()
	var world_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = point
	parameters.collision_mask = 0b1000
	var result : Array = world_state.intersect_point(parameters, 1)
	if not result.is_empty():
		return
	
	#var index = randi_range(0, creatures.size() - 1)
	# 0-GOBLIN 1-PAWN 2-SHEEP
	var index : int = 0
	var random : int = randi() % 101
	if random < 5: index = 0
	elif random < 45: index = 1
	else: index = 2 	
	
	if index == 0:
		if GameManager.current_goblin_counter >= GameManager.max_goblins:
			return
	
	var creature_scene = creatures[index]
	var creature = creature_scene.instantiate()
	creature.global_position = point
	match index:
		0: 
			creature.enemy_name = "GOBLIN"
			GameManager.current_goblin_counter += 1
		1: 
			creature.enemy_name = "PAWN"
		2: 
			creature.enemy_name = "SHEEP"
		
	GameManager.monsters_created_counter += 1
	get_parent().add_child(creature)
	
#======================================================================
func get_point() -> Vector2:
	path_follow_2d.progress_ratio = randf()
	return path_follow_2d.global_position
