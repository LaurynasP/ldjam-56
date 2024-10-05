class_name Inventory
extends Node

@export var items = {}

func add_item(name: String):
	if items.has(name):
		items[name] = items[name] + 1
	else:
		items[name] = 1
	
func remove_item(name: String):
	if items.has(name):
		items[name] = items[name] - 1
	else:
		items[name] = 0
	
func has_item(name: String) -> bool:
	return items.has(name)

func use_item(name: String):
	if !items.has(name): return
	
	if items[name] == 1:
		items.erase(name)
	else:
		items[name] = items[name] - 1
