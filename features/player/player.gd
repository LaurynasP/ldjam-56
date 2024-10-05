class_name Player
extends Node

@export var camera_controller: CameraFreeLook
@export var movement_controller: BasicMovement
@export var interactions_controller: InteractionSourceController

func _ready():
	camera_controller.initialize(true)
	camera_controller.on_rotation_changed(true)
	pass

func _process(delta):
	pass
	
func toggle_input(enabled: bool):
	camera_controller.on_rotation_changed(enabled)
	movement_controller.initialize(enabled)
	
func _on_interaction_controller_on_interactable_hovered(interactable):
	GameManager.current_gameplay.set_hovered_interactable(interactable)


func _on_interaction_controller_on_interactable_unhovered():
	GameManager.current_gameplay.set_hovered_interactable(null)
