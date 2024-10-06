class_name Food 
extends InteractableObject

@export var score: int

func _ready():
	GameManager.current_gameplay.level_total_score += score

func interact():
	GameManager.current_gameplay.eat_food(self)
	GameManager.current_gameplay.make_noise(2, NoiseController.NoiseTypes.EATING)
	SoundEffectManager.play_eating_sound()
	queue_free()
