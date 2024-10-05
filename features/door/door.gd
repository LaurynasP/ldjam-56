class_name Door
extends InteractableObject

var is_open: bool = false;
var closed_rotation = Vector3()  
var open_rotation = Vector3()
var open_angle = 90
<<<<<<< HEAD
var tween_duration = 1.0  # Time it takes to animate the door
=======
var tween_duration = 0.5  # Time it takes to animate the door
@export var switch_open_direction = true;
>>>>>>> 5c817f672314eef83963ec6510e33c7d2276104a


var tween
func _ready() -> void:
	closed_rotation = self.rotation_degrees
	if(switch_open_direction):
		open_rotation = closed_rotation + Vector3(0, open_angle, 0)
	else:
		open_rotation = closed_rotation - Vector3(0, open_angle, 0)


func interact():
<<<<<<< HEAD
	print("Hodor")
	toggle_door()
=======
	toggle_open()
>>>>>>> 5c817f672314eef83963ec6510e33c7d2276104a
	
func toggle_open():
	if is_open:
		close()
	else:
		open()

func open():
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", open_rotation, tween_duration)
	#tween.tween_property(self, "rotation_degrees", self.rotation_degrees, open_rotation, tween_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	is_open = true  # Update the state

func close():
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", closed_rotation, tween_duration)
	#tween.interpolate_property(self, "rotation_degrees", self.rotation_degrees, closed_rotation, tween_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

	is_open = false  # Update the state
