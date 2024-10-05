extends Door

var locked = true
@onready var drill = $Drill
var animation_duration = 2.0

func interact():
	if(locked):
		unlock()
	else:
		toggle_open()

func unlock():
	drill.show()
	var tween = create_tween()
	tween.tween_property(drill, "rotation_degrees", drill. rotation_degrees + Vector3(2000, 0, 0), animation_duration)
	
	
	await tween
	locked = false
	drill.queue_free()
	print("Unlocking")
