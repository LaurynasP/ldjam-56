class_name NoiseUIController
extends Node

@onready var noise_bar = $ProgressBar

func set_value(value: float):
	noise_bar.value = value
