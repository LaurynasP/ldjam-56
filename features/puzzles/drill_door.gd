extends Door

var locked = true
var drilling = false
@onready var drill = $Drill
var animation_duration = 3.77
var drill_noise_per_second =  4


var drillSoundEffect: AudioStreamPlayer3D

func _ready() -> void:
	drillSoundEffect = load("res://features/sound_effects/drill.tscn").instantiate() as AudioStreamPlayer3D

	self.add_child(drillSoundEffect)
	super._ready()
	drill.hide()

func interact():
	if(GameManager.current_gameplay.has_item(ItemsManager.Items.DRILL)):	
		if(locked && !drilling):
			unlock()
		if(!locked):
			toggle_open()

func unlock():
	drilling = true
	drill.show()
	drillSoundEffect.play()
	var tween = create_tween()
	tween.tween_property(drill, "rotation_degrees", drill. rotation_degrees + Vector3(4000, 0, 0), animation_duration)
	
	await tween.finished
	locked = false
	drilling = false
	drill.queue_free()

func _process(delta: float) -> void:
	if(drilling):
		GameManager.current_gameplay.make_noise(drill_noise_per_second * delta, NoiseController.NoiseTypes.DRILL)
