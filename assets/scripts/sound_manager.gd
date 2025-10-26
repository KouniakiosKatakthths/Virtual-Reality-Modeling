extends Node

const sounds := {
	"walk": preload("res://assets/audio clips/walking_randomizer.tres"),
	"sprint": preload("res://assets/audio clips/running_randomizer.tres"), 
	"sneak": preload("res://assets/audio clips/sneaking_randomizer.tres"),
	"pickup": preload("res://assets/audio clips/pickup.wav"),
	"drop": preload("res://assets/audio clips/drop.wav"),
	"lighter": preload("res://assets/audio clips/lighter.wav"),
	"oil": preload("res://assets/audio clips/oil.wav")
}

# Attach a sound effect in the player from a spesific category
func play(category: String, player: Player):
	# Get the sound type from the category
	var type: AudioStream = sounds.get(category);
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
