class_name WorshipPuzzleDummy
extends InteractableObject

var rotating = false
var locked = false
@export var correct_rotation_degrees = 0
var is_correct_direction = false
@onready var sound_effect = $StoneEffect
@onready var ingredient = $Ingredient

signal on_correct()
signal on_incorrect()

func _ready():
	validate_direction()
	
func interact():
	if(!rotating && !locked):
		rotate90()
	
func rotate90():
	rotating = true
	var tween = create_tween()
	sound_effect.play()
	tween.tween_property(self, "rotation_degrees",self.rotation_degrees + Vector3(0, 90, 0), 1.6)
	await tween.finished
	if(rotation_degrees.y >= 360):
		rotation_degrees.y = 0
	
	validate_direction()
	rotating = false

func lock():
	ingredient.visible = false
	locked = true
	var tween = create_tween()
	sound_effect.play()
	tween.tween_property(self, "rotation_degrees",self.rotation_degrees + Vector3(20, 0, 0), 1.6)

func validate_direction():
	if(correct_rotation_degrees == rotation_degrees.y):
		is_correct_direction = true
		on_correct.emit()
	else:
		is_correct_direction = false
	move_ingredient()
		
func move_ingredient():
	var tween = create_tween()
	if(is_correct_direction):
		tween.tween_property(ingredient, "position", Vector3(ingredient.position.x , ingredient.position.y, 2), 0.4)
	else:
		tween.tween_property(ingredient, "position", Vector3(ingredient.position.x, ingredient.position.y, 0), 0.4)
