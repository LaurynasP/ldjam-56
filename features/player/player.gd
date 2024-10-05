class_name Player
extends CharacterBody3D

@export var camera_controller: CameraFreeLook
@export var movement_controller: BasicMovement
@export var interactions_controller: InteractionSourceController
@export var noise_controller: PlayerNoiseSource

var sprinting: bool = false

func _ready():
	camera_controller.initialize(true)
	camera_controller.on_rotation_changed(true)
	noise_controller.set_process(true)
	pass

func _process(delta):
	pass
	
func toggle_sprinting(sprinting: bool):
	self.sprinting = sprinting
	
func toggle_input(enabled: bool):
	camera_controller.on_rotation_changed(enabled)
	movement_controller.initialize(enabled)
	noise_controller.set_process(enabled)
	
func _on_interaction_controller_on_interactable_hovered(interactable):
	GameManager.current_gameplay.set_hovered_interactable(interactable)


func _on_interaction_controller_on_interactable_unhovered():
	GameManager.current_gameplay.set_hovered_interactable(null)
