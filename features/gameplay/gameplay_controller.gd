class_name Gameplay
extends Node

var player: Player

var knight: CharacterController

var hovered_interactable: InteractableObject

var game_paused: bool = false

var inventory: Inventory

var noise: NoiseController

var food_score: int = 0

var level_total_score: int = 0

signal on_game_paused(game_state: bool)

signal on_interactable_hovered(object: InteractableObject)

signal on_food_consumed(food: Food)

signal on_item_added(item: String)

signal on_item_removed(item: String)

var said_hide = false;

func _enter_tree():
	add_uis()	
	add_inventory_controller()
	add_noise_controller()
	
	GameManager.current_gameplay = self

func _ready():
	player = $"../player"
	knight = $"../Knight"

func interact():
	if hovered_interactable:
		hovered_interactable.interact()

func set_hovered_interactable(object: InteractableObject):
	hovered_interactable = object
	
	on_interactable_hovered.emit(hovered_interactable)

func pause_game_toggle():
	game_paused = !game_paused
	
	player.toggle_input(!game_paused)
	knight.set_physics_process(!game_paused)
	knight.set_process(!game_paused)
	noise.set_process(!game_paused)
	
	on_game_paused.emit(game_paused)

func eat_food(food: Food):
	food_score += food.score
	inventory.add_item(food.interactable_name)
	
	if level_completed():
		handle_level_completed()
	else:
		on_food_consumed.emit(food)
	
func add_item(item: String):
	inventory.add_item(item)
	on_item_added.emit(item)
	play_item_sound(item)
	
func play_item_sound(item: String):
	match item:
		ItemsManager.Items.DRILL:
			SoundEffectManager.voiceover.nice_drill.play()
		ItemsManager.Items.SHOVEL:
			SoundEffectManager.voiceover.shovel.play()
	
func remove_item(item: String):
	inventory.remove_item(item)
	on_item_removed.emit(item)
	
func has_item(item: String) -> bool:
	return inventory.has_item(item)

func add_uis():
	var pause_ui = ResourceLoader.load("res://features/pause/ui.tscn")
	var hover_ui = ResourceLoader.load("res://features/object_interacting/ui/object_hover_ui.tscn")
	var gameplay_ui = ResourceLoader.load("res://features/gameplay/ui/gameplay_ui.tscn")
	
	add_child(hover_ui.instantiate())
	add_child(pause_ui.instantiate())
	add_child(gameplay_ui.instantiate())
	
func make_noise(amount: float, noise_type: NoiseController.NoiseTypes):
	noise.noise_level += amount
	
	if level_failed():
		handle_level_failed()
		
	if noise.noise_level > 45 and amount > 1.5:
		if(!said_hide):
			SoundEffectManager.voiceover.hide.play()
			said_hide = true
		knight.target = player.position
		knight.current_speed = knight.speed
		knight.current_acceleration = knight.acceleration
		
		if noise.noise_level > 65:
			knight.current_speed = knight.running_speed
			knight.current_acceleration = knight.running_acceleration

func reduce_noise(amount: float,  noise_type: NoiseController.NoiseTypes):
	noise.noise_level -= amount


func add_noise_controller():
	var noise_controller = new()
	noise_controller.name = "noise_controller"
	noise_controller.set_script(ResourceLoader.load("res://features/noise/noise_controller.gd"))
	add_child(noise_controller)
	
	noise = noise_controller as NoiseController
func add_inventory_controller():
	var inventory_controller = new()
	inventory_controller.name = "inventory_controller"
	inventory_controller.set_script(ResourceLoader.load("res://features/inventory/inventory_controller.gd"))
	add_child(inventory_controller)
	
	inventory = inventory_controller as Inventory

func level_completed() -> bool:
	return level_total_score == food_score

func level_failed() -> bool:
	return noise.noise_level >= 100

func handle_level_completed(): 
	player.toggle_input(false)
	noise.set_process(false)
	knight.set_process(false)
	knight.set_physics_process(false)
	knight.animation_player.pause()
	InputManager.set_process_input(false)
	for child in get_children():
		remove_child(child)
	var victory_ui = ResourceLoader.load("res://features/victory/victory_ui.tscn")
	add_child(victory_ui.instantiate())
	
func handle_level_failed():
	player.toggle_input(false)
	noise.set_process(false)
	knight.set_process(false)
	knight.set_physics_process(false)
	knight.animation_player.pause()
	InputManager.set_process_input(false)
	for child in get_children():
		remove_child(child)
	var failure_ui = ResourceLoader.load("res://features/level_failed/level_failed_ui.tscn")
	add_child(failure_ui.instantiate())
