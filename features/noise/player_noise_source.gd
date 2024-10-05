class_name PlayerNoiseSource
extends Node

@onready var character: Player = $".."

@export var default_noise_level: float = 0.2
@export var sprint_noise_level_multiplier: float = 4

@export var noise_interval: float = 0.3
@export var sprint_noise_interval_multiplier: float = 1.5

var current_timer: float = 0.6
var current_noise_interval_multiplier = 1
var current_noise_level_multiplier = 1
var current_noise_type: NoiseController.NoiseTypes = NoiseController.NoiseTypes.WALKING

var falling_duration: float = 0
var was_falling: bool = false

func _process(delta):
	if character.is_on_floor():
		if was_falling:
			GameManager.current_gameplay.make_noise(3 * (0.3+falling_duration)**2, NoiseController.NoiseTypes.LANDING)
			falling_duration = 0
			was_falling = false
		
		if character.velocity == Vector3.ZERO:
			current_timer = noise_interval
			return
			
		set_noise_values()
		
		current_timer -= delta * current_noise_interval_multiplier
		
		if current_timer <= 0:
			GameManager.current_gameplay.make_noise(default_noise_level * current_noise_level_multiplier, current_noise_type)
			current_timer = noise_interval
	else:
		if character.velocity.y > 0: return
		
		was_falling = true
		falling_duration += delta
		

func set_noise_values():
	if character.sprinting:
		current_noise_interval_multiplier = sprint_noise_interval_multiplier
		current_noise_level_multiplier = sprint_noise_level_multiplier
		current_noise_type = NoiseController.NoiseTypes.SPRINTING
	else:
		current_noise_interval_multiplier = 1
		current_noise_level_multiplier = 1
		current_noise_type = NoiseController.NoiseTypes.WALKING
