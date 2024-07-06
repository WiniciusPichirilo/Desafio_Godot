extends Node2D
class_name Ritual

#======================================================================
#@export var damage_amount: int = 1
#var damage_amount: int = 1
var damage_amount_range : Vector2i = Vector2i(1,8)

#======================================================================
@onready var area : Area2D =$Area2D

#======================================================================
func deal_damage():
	var bodies = area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies"):
			var random_damage_amount = randi_range(damage_amount_range.x,damage_amount_range.y)
			body.damage(random_damage_amount)
			
