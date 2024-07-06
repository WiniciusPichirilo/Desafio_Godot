extends ItemBase

#======================================================================
@export var regeneration_amount: int = 10

#======================================================================
#var area: Area2D

#======================================================================
func _ready() -> void:
	$Area2D.body_entered.connect(on_body_entered)
	super._ready()

#======================================================================
func on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var player: Player = body
		player.heal(regeneration_amount)
		player.meat_collected.emit()
		queue_free()
		
#======================================================================
func _process(delta: float) -> void:
	super._process(delta)
