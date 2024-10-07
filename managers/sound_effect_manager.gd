extends Node

var musicPlayer: AudioStreamPlayer
var eatingSoundEffect:AudioStreamPlayer
var voiceover: Voiceover

func _ready() -> void:
	musicPlayer = load("res://features/music/music_player.tscn").instantiate() as AudioStreamPlayer
	add_child(musicPlayer)
	musicPlayer.finished.connect(play_next_track)
	
	eatingSoundEffect =  load("res://features/sound_effects/eating.tscn").instantiate() as AudioStreamPlayer
	add_child(eatingSoundEffect)
	
	voiceover = load("res://features/voiceover/voiceover.tscn").instantiate()
	add_child(voiceover)
	voiceover.quiet.play()
	
	
	

func play_eating_sound():
	eatingSoundEffect.play()
	
func play_next_track():
	musicPlayer.play()
