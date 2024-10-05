extends Node

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		GameManager.current_gameplay.pause_game_toggle()
		
	if Input.is_action_just_pressed("interact"):
		GameManager.current_gameplay.interact()
