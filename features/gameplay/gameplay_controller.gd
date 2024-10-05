class_name Gameplay
extends Node

var player: Player

var hovered_interactable: InteractableObject

var game_paused: bool = false

var inventory: Inventory

var food_score: int = 0

signal on_game_paused(game_state: bool)

signal on_interactable_hovered(object: InteractableObject)

signal on_food_consumed(food: Food)

func _enter_tree():
	var pause_ui = ResourceLoader.load("res://features/pause/ui.tscn")
	var hover_ui = ResourceLoader.load("res://features/object_interacting/ui/object_hover_ui.tscn")
	var gameplay_ui = ResourceLoader.load("res://features/gameplay/ui/gameplay_ui.tscn")
	
	add_child(hover_ui.instantiate())
	add_child(pause_ui.instantiate())
	add_child(gameplay_ui.instantiate())
	
	var inventory_controller = new()
	inventory_controller.name = "inventory_controller"
	inventory_controller.set_script(ResourceLoader.load("res://features/inventory/inventory_controller.gd"))
	add_child(inventory_controller)
	
	inventory = inventory_controller as Inventory
	
	GameManager.current_gameplay = self

func _ready():
	player = $"../player"

func interact():
	if hovered_interactable:
		hovered_interactable.interact()

func set_hovered_interactable(object: InteractableObject):
	hovered_interactable = object
	
	on_interactable_hovered.emit(hovered_interactable)

func pause_game_toggle():
	game_paused = !game_paused
	
	player.toggle_input(!game_paused)
	
	on_game_paused.emit(game_paused)

func eat_food(food: Food):
	food_score += food.score
	inventory.add_item(food.interactable_name)
	
	on_food_consumed.emit(food)
