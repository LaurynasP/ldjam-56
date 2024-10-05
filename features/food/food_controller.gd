class_name Food 
extends InteractableObject

@export var score: int

func interact():
	GameManager.current_gameplay.eat_food(self)
	GameManager.current_gameplay.make_noise(2, NoiseController.NoiseTypes.EATING)
	queue_free()
