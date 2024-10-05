extends Node

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		GameManager.current_gameplay.pause_game_toggle()
		
	if Input.is_action_just_pressed("interact"):
		GameManager.current_gameplay.interact()
		
	if Input.is_action_pressed("sprint"):
		GameManager.current_gameplay.player.toggle_sprinting(true)
	else:
		GameManager.current_gameplay.player.toggle_sprinting(false)
