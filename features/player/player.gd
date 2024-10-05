class_name Player
extends Node

@export var camera_controller: CameraFreeLook
@export var movement_controller: BasicMovement
@export var interactions_controller: InteractionSourceController

func _ready():
	GameManager.player = self
	camera_controller.initialize(true)
	camera_controller.on_rotation_changed(true)
	pass

func _process(delta):
	pass

func disable_input():
	camera_controller.on_rotation_changed(false)
	


func _on_interaction_controller_on_interactable_hovered(interactable):
	print(interactable.interactable_name)
