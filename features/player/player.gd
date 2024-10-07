class_name Player
extends CharacterBody3D

@export var camera_controller: CameraFreeLook
@export var movement_controller: BasicMovement
@export var interactions_controller: InteractionSourceController
@export var noise_controller: PlayerNoiseSource

var sprinting: bool = false
var is_moving: bool = false

@onready var runningSoundEffect: AudioStreamPlayer3D = $RunningSoundEffect
@onready var flashlight: SpotLight3D = $camera_controller/camera/flashlight

func _ready():
	camera_controller.initialize(true)
	camera_controller.on_rotation_changed(true)
	noise_controller.set_process(true)
	pass
	

func _process(delta):
	var currently_is_moving = is_on_floor() and velocity.length() > 0;
	if(currently_is_moving != is_moving):
		if(currently_is_moving):
			runningSoundEffect.play()
		else:
			runningSoundEffect.stop()
		is_moving = currently_is_moving
	
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
	
func toggle_flashlight():
	flashlight.visible = !flashlight.visible
