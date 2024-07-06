extends Node

#======================================================================
signal game_over

#======================================================================
var player : Player
var player_position : Vector2
var is_game_over : bool = false
var time_elapsed : float = 0.0
var meat_counter : int = 0
var gold_counter : int = 0
var max_monsters_on_gameplay : int = 100
var current_monsters_on_gameplay : int = 0
var monsters_created_counter : int = 0
var monsters_defeated_counter : int = 0
var time_elapsed_string : String = str("")

var max_goblins : int = 10
var current_goblin_counter : int  = 0

#======================================================================
func _process(delta: float) -> void:
	current_monsters_on_gameplay = monsters_created_counter - monsters_defeated_counter
	#print("Monstros no jogo -> ", current_monsters_on_gameplay)
	#print("Goblins no jogo -> ", current_goblin_counter)

	time_elapsed += delta
	var time_eslapsed_in_seconds : int = floori(time_elapsed)
	var seconds : int = time_eslapsed_in_seconds % 60
	var minutes : int = time_eslapsed_in_seconds / 60
	time_elapsed_string = "%02d:%02d" % [minutes, seconds]

#======================================================================
func end_game():
	if is_game_over: 
		return
	is_game_over = true
	game_over.emit()

#======================================================================
func reset() -> void:
	player = null
	#player.position = Vector2.ZERO
	is_game_over = false

	time_elapsed = 0.0
	time_elapsed_string = "00:00"
	meat_counter = 0
	gold_counter = 0
	current_monsters_on_gameplay = 0
	monsters_created_counter = 0
	monsters_defeated_counter = 0	
	current_goblin_counter  = 0	
		
	for connection in game_over.get_connections():
		game_over.disconnect(connection.callable)
		
	
