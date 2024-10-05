class_name Drawer
extends InteractableObject

var is_open: bool = false;
@export var stay_open: bool = false;

var closed_position = Vector3()  
var open_position = Vector3()


var tween_duration = 0.5  # Time it takes to animate the door
@export var open_direction: Vector3 = Vector3.BACK
@export var open_distance: float = 1.0


var tween
func _ready() -> void:
	closed_position = self.position
	open_position = closed_position + open_direction * open_distance
		


func interact():
	toggle_open()

func toggle_open():
	GameManager.current_gameplay.make_noise(5, NoiseController.NoiseTypes.DOOR_OPEN)
	if is_open:
		if(!stay_open):
			close()
	else:
		open()

func open():
	var tween = create_tween()
	tween.tween_property(self, "position", open_position, tween_duration)
	is_open = true

func close():
	var tween = create_tween()
	tween.tween_property(self, "position", closed_position, tween_duration)

	is_open = false  # Update the state
