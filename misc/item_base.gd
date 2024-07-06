extends Node2D
class_name ItemBase

#======================================================================
@export var duration_in_game : float = 30.0

#======================================================================
var cooldown : float = 0.0

#======================================================================
func _ready() -> void:
	cooldown = duration_in_game

#======================================================================
func _process(delta: float) -> void:
	cooldown -= delta
	if cooldown > 0:
		return
	queue_free()
	
