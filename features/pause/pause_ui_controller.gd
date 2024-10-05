extends Node

@onready var panel: Container = $PanelContainer

func _ready():
	GameManager.on_game_paused.connect(on_paused)
	
	on_paused(GameManager.game_paused)
	
func on_paused(is_paused):
	if is_paused:
		panel.show()
	else:
		panel.hide()
