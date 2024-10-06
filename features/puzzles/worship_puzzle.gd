extends Node

@onready var D1 = $D1
@onready var D2 = $D2
@onready var D3 = $D3
@onready var D4 = $D4
@onready var reward: Node3D = $reward
@onready var complete_sound_effect = $HolyChoir

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	D1.on_correct.connect(validate_all_correct)
	D2.on_correct.connect(validate_all_correct)
	D3.on_correct.connect(validate_all_correct)
	D4.on_correct.connect(validate_all_correct)
	reward.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func validate_all_correct():
	if(D1.is_correct_direction && D2.is_correct_direction && D3.is_correct_direction && D4.is_correct_direction):
		handle_puzzle_solved()
	
	
func handle_puzzle_solved():
	D1.lock()
	D2.lock()
	D3.lock()
	D4.lock()
	handle_reward()
	
func handle_reward():
	reward.visible = true
	var size_tween = create_tween()
	var height_tween = create_tween()
	complete_sound_effect.play()
	size_tween.tween_property(reward, "scale", Vector3(3,3,3), 0.5)
	height_tween.tween_property(reward, "position", Vector3(0,0,0), 4)
	
