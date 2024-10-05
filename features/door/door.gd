class_name Door
extends InteractableObject

var is_open: bool = false;
var closed_rotation = Vector3()  
var open_rotation = Vector3()
var open_angle = 90
var tween_duration = 0.5  # Time it takes to animate the door
@export var switch_open_direction = true;


func _ready() -> void:
	closed_rotation = self.rotation_degrees
	if(switch_open_direction):
		open_rotation = closed_rotation + Vector3(0, open_angle, 0)
	else:
		open_rotation = closed_rotation - Vector3(0, open_angle, 0)


func interact():
	toggle_open()
	
func toggle_open():
	if is_open:
		close()
	else:
		open()

func open():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation_degrees", open_rotation, tween_duration)
	is_open = true 

func close():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation_degrees", closed_rotation, tween_duration)

	is_open = false 
