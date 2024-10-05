class_name PlayerNoiseSource
extends Node

@onready var character: Player = $".."

@export var default_noise_level: float = 0.4
@export var sprint_noise_level_multiplier: float = 2.3

@export var noise_interval: float = 0.3
@export var sprint_noise_interval_multiplier: float = 1.5

var current_timer: float = 0.6
var current_noise_interval_multiplier = 1
var current_noise_level_multiplier = 1
var current_noise_type: NoiseController.NoiseTypes = NoiseController.NoiseTypes.WALKING

func _process(delta):
	if character.velocity == Vector3.ZERO: 
		current_timer = noise_interval
		return
	
	set_noise_values()
	
	current_timer -= delta * current_noise_interval_multiplier
	
	if current_timer <= 0:
		GameManager.current_gameplay.make_noise(default_noise_level * current_noise_level_multiplier, current_noise_type)
		current_timer = noise_interval
	
	pass

func set_noise_values():
	if character.sprinting:
		current_noise_interval_multiplier = sprint_noise_interval_multiplier
		current_noise_level_multiplier = sprint_noise_level_multiplier
		current_noise_type = NoiseController.NoiseTypes.SPRINTING
	else:
		current_noise_interval_multiplier = 1
		current_noise_level_multiplier = 1
		current_noise_type = NoiseController.NoiseTypes.WALKING
