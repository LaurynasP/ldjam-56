class_name CharacterController
extends CharacterBody3D

@export var speed: float = 1.7
@export var acceleration: float = 7

@export var running_speed: float = 2.6
@export var running_acceleration: float = 10

@export var stopping_distance: float = 0.4

@export var idle_timeout: float = 3
@export var turn_speed: float = 5

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var visibility_ray: RayCast3D = $RayCast3D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var starting_position: Vector3
var target: Vector3
var current_idle_timer = 0

var idle_anim = "Idle"
var running_anim = "Running_A"

var current_speed = speed
var current_acceleration = acceleration

var prev_position: Vector3

var anti_stuck_timout = 1.3

var stuck_timer = 0

func _ready():
	starting_position = position
	prev_position = global_position

func _process(delta):
	var direction = Vector3()
	
	if global_position.distance_to(GameManager.current_gameplay.player.global_position) < 0.61:
		GameManager.current_gameplay.handle_level_failed()
	
	if prev_position.distance_to(global_position) < 0.015 and target != starting_position and target != Vector3.ZERO:
		stuck_timer += delta
	else: 
		stuck_timer = 0
		
	if stuck_timer > anti_stuck_timout:
		target = starting_position
	
	prev_position = global_position

	var total = abs(velocity.x) + abs(velocity.z) + abs(velocity.y)
	
	var scale = lerp(-1, 0, total / (speed * 1.7))
	
	if scale > 1:
		print("pre " + str(scale))
		scale = lerp(0, 1, total / running_speed)

	animation_tree.set("parameters/Main/blend_amount", scale)
	
	var player_target = GameManager.current_gameplay.player.global_position
	
	var distance_to_player_breached = player_target.distance_to(global_position) < 3.5
	
	if target == Vector3.ZERO and position.distance_to(starting_position) > 0.5:
		if current_idle_timer > idle_timeout:
			target = starting_position
			current_idle_timer = 0
		else:
			current_idle_timer += delta
			
			if distance_to_player_breached:
				target_player()
	
	if position.distance_to(target) < stopping_distance:
		velocity = Vector3.ZERO
		target = Vector3.ZERO
		return
	
	if target == Vector3.ZERO:
		return
	
	if distance_to_player_breached:
		target_player()
	
	current_idle_timer = 0
	
	nav_agent.target_position = target
	
	direction = nav_agent.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * current_speed, current_acceleration * delta)
	
	var angle = Vector2(velocity.z, velocity.x).angle()
		
	rotation = Vector3(rotation.x, lerp_angle(rotation.y, angle, delta * turn_speed), rotation.z)
	
	move_and_slide()

func target_player():
	current_speed = running_speed
	current_acceleration = running_acceleration
	
	var player_target = GameManager.current_gameplay.player.global_position
	
	var query = PhysicsRayQueryParameters3D.create(visibility_ray.global_position, player_target) 

	var collision = get_world_3d().direct_space_state.intersect_ray(query)
	
	if collision:
		target = collision.get("position")
