class_name Level
extends Node

func _ready():
	var gameplay_controller = ResourceLoader.load("res://features/gameplay/gameplay_controller.tscn")
	
	add_child(gameplay_controller.instantiate())
