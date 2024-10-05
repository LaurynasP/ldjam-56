extends Node

@onready var panel: Container = $PanelContainer

func _ready():
	GameManager.current_gameplay.on_game_paused.connect(on_paused)
	
	on_paused(GameManager.current_gameplay.game_paused)
	
func on_paused(is_paused):
	if is_paused:
		panel.show()
	else:
		panel.hide()
