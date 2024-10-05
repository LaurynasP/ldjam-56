extends Node

@onready var panel: PanelContainer = $"center_container/margin/panel"
@onready var label: Label = $"center_container/margin/panel/margin/hoverable_name"

func _ready():
	if GameManager.current_gameplay:
		GameManager.current_gameplay.on_interactable_hovered.connect(on_hovered)

func on_hovered(interactable: InteractableObject):
	if interactable:
		label.text = interactable.interactable_name
		panel.show()
	else:
		label.text = ""
		panel.hide()
	
