extends CanvasLayer
class_name  GameOverUI

#======================================================================
@onready var time_label : Label = %TimeLabel
@onready var monsters_label : Label = %MonstersLabel

#======================================================================
@export var restart_delay : float = 10.0

#======================================================================
var restart_cooldown : float = 0.0
#var time_survived: String
#var monster_defeated : int = 0

#======================================================================
func _ready() -> void:
	restart_cooldown = restart_delay
	time_label.text = GameManager.time_elapsed_string
	monsters_label.text = str(GameManager.monsters_defeated_counter)
	
#======================================================================
func _process(delta: float) -> void:
	restart_cooldown -= delta
	if restart_cooldown <= 0:
		restart_game()
		
#======================================================================
func restart_game() -> void:
	GameManager.reset()
	get_tree().reload_current_scene()
	
	
	
	
