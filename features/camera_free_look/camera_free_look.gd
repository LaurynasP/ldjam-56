class_name CameraFreeLook
extends Node3D

@export var speed: float = 5
@export var speed_run_multipler: float = 2
@export var mouse_sensitivity: float = 3

var offset: Vector2 = Vector2.ZERO
var rotation_enabled: bool = false
var current_speed: float = 0

var parent: Node3D

func initialize(enabled: bool) -> void:
	set_process(enabled)
	set_process_input(enabled)
	set_physics_process(enabled)
	parent = get_parent()

func _ready() -> void:
	current_speed = speed

func _physics_process(delta: float) -> void:
	rotate_mouse(delta)

	offset = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if !rotation_enabled: return
	if event is not InputEventMouseMotion: return

	offset = event.relative

func on_rotation_changed(enabled: bool):
	if enabled:
		enable_rotation()
	else:
		disable_rotation()

func disable_rotation() -> void:
	var viewport: Viewport = get_viewport()
	var screenCenter = viewport.get_visible_rect().size / 2
	viewport.warp_mouse(screenCenter)
	rotation_enabled = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func enable_rotation() -> void:
	rotation_enabled = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func rotate_mouse(delta: float):
	if (!rotation_enabled):
		return

	var x = -offset.x
	var y = -offset.y

	rotate_x(deg_to_rad(y * delta * mouse_sensitivity))
	rotation.x = clamp(rotation.x, deg_to_rad(-89), deg_to_rad(89))
	parent.rotate_y(deg_to_rad(x * delta * mouse_sensitivity))
