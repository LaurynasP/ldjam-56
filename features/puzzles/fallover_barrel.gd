extends InteractableObject

enum State { STANDING, FALLING_OVER, FALLEN_OVER, ROLLING, STOPPED }
var state: State = State.STANDING

var barrelFallEffect: AudioStreamPlayer3D
var barrelRollEffect: AudioStreamPlayer3D

func interact():
	match state:
		State.STANDING:
			if(GameManager.current_gameplay.has_item(ItemsManager.Items.SHOVEL)):
				push_over()
			pass
		State.FALLING_OVER:
			pass
		State.FALLEN_OVER:
			roll()
			pass
		State.ROLLING:
			pass
		State.STOPPED:
			pass
			
func _ready() -> void:
	barrelFallEffect = load("res://features/sound_effects/barrel_fall.tscn").instantiate() as AudioStreamPlayer3D
	barrelRollEffect = load("res://features/sound_effects/barrel_roll.tscn").instantiate() as AudioStreamPlayer3D
	self.add_child(barrelFallEffect)
	self.add_child(barrelRollEffect)
	updateName()

func push_over():
	GameManager.current_gameplay.remove_item(ItemsManager.Items.SHOVEL)
	setState(State.FALLING_OVER)
	var tween = create_tween()
	var tween2 = create_tween()
	tween.tween_property(self, "rotation_degrees", Vector3(90, 0, 0), 1.0)
	tween2.tween_property(self, "position", self.position + Vector3(0,0,1), 1.0)
	barrelFallEffect.play()
	await tween.finished
	await tween2.finished
	barrelFallEffect.stop()
	setState(State.FALLEN_OVER)
	
	
func roll():
	setState(State.ROLLING)
	var tween = create_tween()
	tween.tween_property(self, "position", self.position + Vector3(5.2,0, 0), 2.0)
	barrelRollEffect.play()
	await tween.finished
	barrelRollEffect.stop()
	setState(State.STOPPED)


func setState(newState: State):
	state = newState
	updateName()
	
func updateName():
	match state:
		State.STANDING:
			self.interactable_name ="Push Over"
		State.FALLING_OVER:
			self.interactable_name = ""
		State.FALLEN_OVER:
			self.interactable_name = "Roll"
		State.ROLLING:
			self.interactable_name = ""
		State.STOPPED:
			self.interactable_name = ""
