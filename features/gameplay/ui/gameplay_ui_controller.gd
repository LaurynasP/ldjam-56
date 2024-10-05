extends Node

@onready var score_label: Label = $"margin/center/vertical/score/value"
@onready var noise_label: Label = $"margin/center/vertical/noise/value"
@onready var noise_ui_controller: NoiseUIController = $margin/center/vertical/noise_ui
func _ready():
	GameManager.current_gameplay.on_food_consumed.connect(on_food_consumed)
	
	score_label.text = str(GameManager.current_gameplay.food_score)
	

func _process(delta):
	noise_label.text = "" #"%3.3f" % GameManager.current_gameplay.noise.noise_level
	noise_ui_controller.set_value(GameManager.current_gameplay.noise.noise_level)

func on_food_consumed(food: Food):
	score_label.text = str(GameManager.current_gameplay.food_score)
	
