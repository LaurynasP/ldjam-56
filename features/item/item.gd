class_name Item
extends InteractableObject

@export var item_type: String

func _ready() -> void:
	if(!item_type):
		push_error("Item does not have assigned type")
	
func interact():
	GameManager.current_gameplay.add_item(item_type)
	queue_free()
