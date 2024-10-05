extends Node

@onready var noise_ui_controller: NoiseUIController = $margin/center2/vertical/noise/noise_ui 
@onready var level_progress_bar: ProgressBar = $margin/center2/vertical/level_progress/margin/progress_bar

func _process(delta):
	noise_ui_controller.set_value(GameManager.current_gameplay.noise.noise_level)
	level_progress_bar.value = GameManager.current_gameplay.food_score
	level_progress_bar.max_value = GameManager.current_gameplay.level_total_score
	
