extends CanvasLayer

#======================================================================
@onready var timer_label : Label = %TimerLabel
@onready var meat_label : Label = %MeatLabel
@onready var gold_label : Label = %GoldLabel

#======================================================================
#var time_elapsed : float = 0.0
#var meat_counter : int = 0
#var gold_counter : int = 0

#======================================================================
#func _ready() -> void:
	#GameManager.player.meat_collected.connect(on_meat_collected)
	#meat_label.text = str(GameManager.meat_counter)
	#GameManager.player.gold_collected.connect(on_gold_collected)
	#gold_label.text = str(GameManager.gold_counter)

#======================================================================
func _process(delta: float) -> void:
#	time_elapsed += delta
#	var time_eslapsed_in_seconds : int = floori(time_elapsed)
#	var seconds : int = time_eslapsed_in_seconds % 60
#	var minutes : int = time_eslapsed_in_seconds / 60
	timer_label.text = GameManager.time_elapsed_string
	meat_label.text = str(GameManager.meat_counter)
	gold_label.text = str(GameManager.gold_counter)
		
#======================================================================
#func on_meat_collected(regeneration_value : int) -> void:
#	meat_counter += 1
#	meat_label.text = str(meat_counter)
	
#======================================================================
#func on_gold_collected() -> void:
#	gold_counter += randi_range(1,50)
#	gold_label.text = str(gold_counter)	
	
	
	
