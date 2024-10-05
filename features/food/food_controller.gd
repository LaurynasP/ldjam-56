class_name Food 
extends InteractableObject

@export var score: int

func interact():
	GameManager.current_gameplay.eat_food(self)
	queue_free()
