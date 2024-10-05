extends Node


func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if GameManager.player:
			GameManager.player.disable_input()
