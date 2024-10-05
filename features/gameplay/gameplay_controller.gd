class_name Gameplay
extends Node

func _ready():
	var pause_ui = ResourceLoader.load("res://features/pause/ui.tscn")
	var hover_ui = ResourceLoader.load("res://features/object_interacting/ui/object_hover_ui.tscn")
	
	add_child(hover_ui.instantiate())
	add_child(pause_ui.instantiate())
