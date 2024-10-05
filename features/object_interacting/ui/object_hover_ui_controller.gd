extends Node

@onready var label: Label = $center_container/margin/hoverable_name

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.on_interactable_hovered.connect(on_hovered)
	pass # Replace with function body.

func on_hovered(interactable: InteractableObject):
	if interactable:
		label.text = interactable.interactable_name
	else:
		label.text = ""
	
