class_name Door 
extends InteractableObject

var is_open: bool = false;
var closed_rotation = Vector3()  
var open_rotation = Vector3()
var open_angle = 90
var tween_duration = 0.5  # Time it takes to animate the door


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
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation_degrees", open_rotation, tween_duration)
	is_open = true 

func close_door():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation_degrees", closed_rotation, tween_duration)

	is_open = false 
