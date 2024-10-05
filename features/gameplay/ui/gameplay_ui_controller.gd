extends Node

@onready var score_label: Label = $"margin/center/vertical/score/value"

func _ready():
	GameManager.current_gameplay.on_food_consumed.connect(on_food_consumed)
	
	score_label.text = str(GameManager.current_gameplay.food_score)
	
func on_food_consumed(food: Food):
	score_label.text = str(GameManager.current_gameplay.food_score)
	
