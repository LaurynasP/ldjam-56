class_name Level
extends Node

func _enter_tree():
	var gameplay_controller = ResourceLoader.load("res://features/gameplay/gameplay_controller.tscn")
	
	add_child(gameplay_controller.instantiate())

func _ready():
	GameManager.current_gameplay.pause_game_toggle()
