extends Node

var player: Player

var hovered_interactable: InteractableObject

var game_paused: bool = false

signal on_game_paused(game_state: bool)

signal on_interactable_hovered(object: InteractableObject)

func interact():
	if hovered_interactable:
		hovered_interactable.interact()

func set_hovered_interactable(object: InteractableObject):
	hovered_interactable = object
	
	on_interactable_hovered.emit(hovered_interactable)

func pause_game_toggle():
	game_paused = !game_paused
	
	on_game_paused.emit(game_paused)
