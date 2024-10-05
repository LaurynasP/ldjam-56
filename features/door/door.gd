class_name Door 
extends InteractableObject

var is_open: bool = false;
var closed_rotation = Vector3()  
var open_rotation = Vector3()
var open_angle = 90
var tween_duration = 1.0  # Time it takes to animate the door


var tween
func _ready() -> void:
	closed_rotation = self.rotation_degrees
	open_rotation = closed_rotation + Vector3(0, open_angle, 0)


func interact():
	print("Hodor")
	toggle_door()
	
func toggle_door():
	if is_open:
		close_door()
	else:
		open_door()

func open_door():
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", open_rotation, tween_duration)
	#tween.tween_property(self, "rotation_degrees", self.rotation_degrees, open_rotation, tween_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	is_open = true  # Update the state

func close_door():
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", closed_rotation, tween_duration)
	#tween.interpolate_property(self, "rotation_degrees", self.rotation_degrees, closed_rotation, tween_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

	is_open = false  # Update the state
