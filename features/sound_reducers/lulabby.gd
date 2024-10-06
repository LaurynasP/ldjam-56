extends InteractableObject

@onready var lulabby:AudioStreamPlayer3D = $Music
@export var reduce_noise_per_second = 1
func interact():
	if(!lulabby.playing):
		lulabby.play()

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(lulabby.playing):
		GameManager.current_gameplay.reduce_noise(reduce_noise_per_second * delta, NoiseController.NoiseTypes.LULLABY)
