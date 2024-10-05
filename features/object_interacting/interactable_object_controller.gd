class_name InteractableObject
extends Node3D

@export var interactable_name: String

func interact(): 
	push_error("Child class must implement this method")
