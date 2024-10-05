class_name Player
extends Node

@export var camera_controller: CameraFreeLook
@export var movement_controller: BasicMovement

func _ready():
	GameManager.player = self
	camera_controller.initialize(true)
	camera_controller.on_rotation_changed(true)
	pass

func _process(delta):
	pass

func disable_input():
	camera_controller.on_rotation_changed(false)
	
