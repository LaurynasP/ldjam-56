class_name BasicMovement
extends Node

@export var speed: float = 5
@export var sprint_speed: float = 8
@export var lerp_speed: float = 5

var parent: CharacterBody3D

var movement_enabled: bool

var current_speed: float = speed

func initialize(enabled: bool) -> void:
	set_process(enabled)
	set_process_input(enabled)
	set_physics_process(enabled)
	parent = get_parent()

func _ready():
	initialize(true)

func _input(event):
	if Input.is_action_pressed("sprint"):
		current_speed = sprint_speed
	else:
		current_speed = speed

func _physics_process(delta):
	var velocity = Input.get_vector("move_left", "move_right", "move_backwards", "move_forwards")
		
	velocity *= delta
	velocity *= current_speed * 10
	
	parent.velocity = parent.transform.basis * Vector3(velocity.x, 0, velocity.y)
	parent.move_and_slide()
