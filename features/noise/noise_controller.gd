class_name NoiseController
extends Node

enum NoiseTypes {
	WALKING,
	SPRINTING,
	EATING,
	LANDING,
	DOOR_OPEN,
	DRAWER_OPEN
}

var noise_level: float = 0
var noise_reduction_rate: float = 1 / 0.6

func _process(delta):
	noise_level -= delta * noise_reduction_rate
	
	if noise_level < 0:
		noise_level = 0
	else: if noise_level > 100:
		noise_level = 100
