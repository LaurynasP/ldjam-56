class_name InteractionSourceController
extends Node

@onready var ray_cast_3d: RayCast3D = $ray

signal on_interactable_hovered(interactable)

signal on_interactable_unhovered

func _ready():
	pass

func _physics_process(delta):
	if ray_cast_3d.is_colliding():
		var collider = ray_cast_3d.get_collider()
		if collider is StaticBody3D:
			var object = (collider as StaticBody3D).get_parent_node_3d().get_parent_node_3d()
			
			if object and object is InteractableObject:
				if !GameManager.hovered_interactable:
					on_interactable_hovered.emit(object as InteractableObject)
	else:
		if GameManager.hovered_interactable:
			on_interactable_unhovered.emit()
