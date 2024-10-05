class_name BasicMovement
extends Node

@export var speed: float = 5
@export var sprint_speed: float = 8
@export var lerp_speed: float = 5

@export var jump_height: float = 1
@export var jump_time_to_peak: float = 0.2
@export var jump_time_to_descend: float = 0.3

var parent: CharacterBody3D
var movement_enabled: bool
var current_speed: float = speed

var jump_velocity: float
var jump_gravity: float
var fall_gravity: float

func initialize(enabled: bool) -> void:
	set_process(enabled)
	set_process_input(enabled)
	set_physics_process(enabled)

func _ready():
	jump_velocity = 2 * jump_height / jump_time_to_peak
	jump_gravity = (-2 * jump_height) / pow(jump_time_to_peak, 2)
	fall_gravity = (-2 * jump_height) / pow(jump_time_to_descend, 2)
	
	parent = get_parent()

func _input(event):
	if Input.is_action_pressed("sprint"):
		current_speed = sprint_speed
	else:
		current_speed = speed

func _physics_process(delta):
	var velocity = Input.get_vector("move_left", "move_right", "move_backwards", "move_forwards")
		
	velocity *= delta
	velocity *= current_speed * 15
	
	var fall_speed = parent.velocity.y
	fall_speed += get_gravity() * delta
	
	if Input.is_action_just_pressed("ui_accept") and parent.is_on_floor():
		fall_speed = jump_velocity

	parent.velocity = parent.transform.basis * Vector3(velocity.x, fall_speed, velocity.y)
	
	parent.move_and_slide()

func get_gravity() -> float:
	if parent.velocity.y > 0:
		return jump_gravity
	else:
		return fall_gravity;
