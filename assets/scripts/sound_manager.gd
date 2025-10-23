extends Node

const sounds := {
	"walk": preload("res://assets/audio clips/footsteps.mp3"),
	"sprint": preload("res://assets/audio clips/footsteps.mp3"), 
	"sneak": preload("res://assets/audio clips/footsteps.mp3"),
	"pickup": preload("res://assets/audio clips/footsteps.mp3"),
	"drop": preload("res://assets/audio clips/footsteps.mp3")
}

# Attach a sound effect in the player from a spesific category
func play(category: String, player: Player):
	# Get the sound type from the category
	var type: Resource = sounds.get(category);
	if type == null: return;
	
	# Create and setup the audio player
	var audio_player = AudioStreamPlayer3D.new();
	audio_player.stream = type;
	
	# Lifetime of the audio player is managed in this script
	add_child(audio_player);
	
	# Set the position of the audio player to the players position
	audio_player.global_transform = player.global_transform;
	
	audio_player.finished.connect(func(): 
		audio_player.queue_free();
	);
	
	audio_player.play();
