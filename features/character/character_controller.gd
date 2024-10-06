class_name CharacterController
extends CharacterBody3D

@export var target: Vector3
@export var stopping_distance: float = 0.4
@export var starting_position: Vector3
@export var idle_timeout: float = 3

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var animator: AnimationPlayer = $AnimationPlayer

var idle_anim = "Idle"
var running_anim = "Running_A"

var current_idle_timer = 0

func _ready():
	starting_position = position

func _process(delta):
	var direction = Vector3()
	
	handle_animation()
	
	if target == Vector3.ZERO and position.distance_to(starting_position) > 0.5:
		if current_idle_timer > idle_timeout:
			target = starting_position
			current_idle_timer = 0
		else:
			current_idle_timer += delta
	
	if position.distance_to(target) < stopping_distance:
		velocity = Vector3.ZERO
		target = Vector3.ZERO
		return
	
	if target == Vector3.ZERO:
		return
	
	current_idle_timer = 0
	
	nav_agent.target_position = target
	
	direction = nav_agent.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * 3, 7 * delta)
	
	var angle = Vector2(velocity.z, velocity.x).angle()
		
	rotation = Vector3(rotation.x, lerp_angle(rotation.y, angle, delta * 5), rotation.z)
	
	move_and_slide()

func handle_animation():
	if velocity == Vector3.ZERO && current_anim() != idle_anim:
		animator.play(idle_anim)
	
	if velocity.x > 0.05 or velocity.z > 0.05:
		animator.play(running_anim)
		
func current_anim() -> String:
	return animator.current_animation.get_basename()

func _on_front_area_3d_body_entered(body: Node3D):
	var door: Door = body.get_parent_node_3d().get_parent_node_3d() as Door
	if door and !door.is_open:
		if door.opening_tween:
			print(str(door.opening_tween.is_running()))
		
		door.toggle_open_noiseless()


func _on_back_area_3d_body_exited(body):
	var door: Door = body.get_parent_node_3d().get_parent_node_3d() as Door
	if door and door.is_open:
		if door.closing_tween:
			print(str(door.closing_tween.is_running()))
		door.toggle_open_noiseless()
