class_name BasicMovement
extends Node

@export var speed: float = 5
@export var sprint_speed: float = 8
@export var lerp_speed: float = 5
@export var gravity_multiplier = 20

const JUMP_VELOCITY = 50

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
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
	
	var fall_speed = 0
	
	if not parent.is_on_floor():
		fall_speed -= gravity * delta * gravity_multiplier

	if Input.is_action_just_pressed("ui_accept") and parent.is_on_floor():
		fall_speed = JUMP_VELOCITY
	
	parent.velocity = parent.transform.basis * Vector3(velocity.x, fall_speed, velocity.y)
	parent.move_and_slide()
