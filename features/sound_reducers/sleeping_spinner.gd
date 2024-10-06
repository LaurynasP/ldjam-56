extends InteractableObject

@export var reduce_noise_per_second = 1
@export var spin_duration = 30.0
var is_spinning = false

func interact():
	if(!is_spinning):
		spin()

func spin():
	SoundEffectManager.voiceover.goodnight.play()
	is_spinning = true
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", self.rotation_degrees + Vector3(0, spin_duration * 180, 0), spin_duration)
	await tween.finished
	is_spinning = false
	
func _process(delta: float) -> void:
	if(is_spinning):
		GameManager.current_gameplay.reduce_noise(reduce_noise_per_second * delta, NoiseController.NoiseTypes.SLEEPING_SPINNER)
