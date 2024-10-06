extends Node

var musicPlayer: AudioStreamPlayer
var eatingSoundEffect:AudioStreamPlayer


func _ready() -> void:
	musicPlayer = load("res://features/music/music_player.tscn").instantiate() as AudioStreamPlayer
	add_child(musicPlayer)
	
	eatingSoundEffect =  load("res://features/sound_effects/eating.tscn").instantiate() as AudioStreamPlayer
	add_child(eatingSoundEffect)
	
	

func play_eating_sound():
	eatingSoundEffect.play()
