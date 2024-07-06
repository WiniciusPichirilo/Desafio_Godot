extends ItemBase

#======================================================================
@export var gold_amount: int = 10
#@export var duration_in_game : float = 30.0

#======================================================================
var area: Area2D
#var cooldown : float = 0.0

#======================================================================
func _ready() -> void:
	$Area2D.body_entered.connect(on_body_entered)
	super._ready()

#======================================================================
func on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var player: Player = body
		player.gold_collected.emit()
		queue_free()
		
#======================================================================
func _process(delta: float) -> void:
	super._process(delta)
	
