extends Door

var locked = true
var drilling = false
@onready var drill = $Drill
var animation_duration = 2.0

func _ready():
	super._ready()
	drill.hide()
	

func interact():
	if(locked && !drilling):
		unlock()
	if(!locked):
		toggle_open()

func unlock():
	drilling = true
	drill.show()
	var tween = create_tween()
	tween.tween_property(drill, "rotation_degrees", drill. rotation_degrees + Vector3(4000, 0, 0), animation_duration)
	
	
	await tween.finished
	locked = false
	drill.queue_free()
	print("Unlocking")
