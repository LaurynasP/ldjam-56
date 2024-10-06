extends Node

# Array to store the AudioStreamPlayer nodes
var audio_players = []
# Index to keep track of the previous AudioStreamPlayer
var previous_player_index = -1

func _ready():
	# Get all AudioStreamPlayer nodes
	audio_players = get_children()

	# Make sure only AudioStreamPlayer nodes are stored
	audio_players = audio_players.filter(func(child): return child is AudioStreamPlayer)

	if audio_players.size() > 0:
		# Start playing a random track
		play_random_track()

# Function to play a random audio track
func play_random_track():
	var next_player_index = get_random_track_index()
	
	if previous_player_index != -1 and audio_players[previous_player_index].is_playing():
		audio_players[previous_player_index].stop()  # Stop the previous track if it's playing
	
	# Play the selected track
	var current_player = audio_players[next_player_index]
	current_player.play()
	
	# Update the previous track index
	previous_player_index = next_player_index

	# Connect the finished signal to a method that plays the next random track
	await current_player.finished
	on_track_finished()

# Method to get a random track index, ensuring it's not the same as the previous track
func get_random_track_index() -> int:
	var random_index = randi() % audio_players.size()
	
	# Keep generating a random index if it matches the previous one
	while random_index == previous_player_index:
		random_index = randi() % audio_players.size()
	
	return random_index

# Signal callback for when an audio track finishes
func on_track_finished():
	play_random_track()  # Play another random track when the current one finishes
