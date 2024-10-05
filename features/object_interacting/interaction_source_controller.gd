class_name InteractionSourceController
extends Node

@onready var ray_cast_3d: RayCast3D = $"../camera_controller/camera/ray"

signal on_interactable_hovered(interactable)

signal on_interactable_unhovered

func _ready():
	pass

func _physics_process(delta):
	if ray_cast_3d.is_colliding():
		var collider = ray_cast_3d.get_collider()
		if collider is StaticBody3D:
			var interactable: InteractableObject = null
			
			var parent = collider.get_parent_node_3d()
			while parent:
				if parent is InteractableObject:
					interactable = parent as InteractableObject
					break
				else:
					parent = parent.get_parent_node_3d()
			
			on_interactable_hovered.emit(interactable)
	else:
		if GameManager.current_gameplay.hovered_interactable:
			on_interactable_unhovered.emit()
