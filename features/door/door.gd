class_name Door
extends InteractableObject

var is_open: bool = false;
var closed_rotation = Vector3()  
var open_rotation = Vector3()
var open_angle = 90

var tween_duration = 0.5 
@export var open_direction = Vector3(0,1,0)
@export var switch_open_direction = true;

var doorSoundEffect: AudioStreamPlayer3D

var opening_tween: Tween
var closing_tween: Tween

func _ready() -> void:
	doorSoundEffect = load("res://features/sound_effects/door.tscn").instantiate() as AudioStreamPlayer3D

	self.add_child(doorSoundEffect)
	
	closed_rotation = self.rotation_degrees
	if(switch_open_direction):
		open_rotation = closed_rotation + open_direction * open_angle
	else:
		open_rotation = closed_rotation - open_direction * open_angle


func interact():
	toggle_open()

func toggle_open():
	GameManager.current_gameplay.make_noise(5, NoiseController.NoiseTypes.DOOR_OPEN)
	play_door_sound_effect()
	if is_open:
		close()
	else:
		open()

func toggle_open_noiseless():
	play_door_sound_effect()
	if is_open:
		close()
	else:
		open()

func open():
	opening_tween = create_tween()
	opening_tween.tween_property(self, "rotation_degrees", open_rotation, tween_duration)
	is_open = true 

func close():
	closing_tween = create_tween()
	closing_tween.tween_property(self, "rotation_degrees", closed_rotation, tween_duration)
	
	is_open = false 


func play_door_sound_effect():
	doorSoundEffect.play()
