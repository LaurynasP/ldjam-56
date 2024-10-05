extends Node

func _ready():
	GameManager.on_game_paused.connect(on_game_pause_toggled)

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		GameManager.pause_game_toggle()

func on_game_pause_toggled(is_game_paused: bool):
	if GameManager.player:
		GameManager.player.toggle_input(!is_game_paused)
