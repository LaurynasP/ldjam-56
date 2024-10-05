class_name BasicMovement
extends Node

@export var speed: float = 5

var parent: CharacterBody3D

var movement_enabled: bool

func initialize(enabled: bool) -> void:
	set_process(enabled)
	set_process_input(enabled)
	set_physics_process(enabled)
	parent = get_parent()

func _ready():
	initialize(true)

func _process(delta):
	pass

func _physics_process(delta):
	var velocity: Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		
	velocity *= delta
	velocity *= speed * 10
	
	parent.velocity = Vector3(velocity.x, 0, velocity.y)
