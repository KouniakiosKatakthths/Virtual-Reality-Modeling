extends Node3D

# Get the player instance from the groups
@onready var player = get_tree().get_first_node_in_group("player") as Player;
# The fire particle system 
@onready var fire_particles: PackedScene = preload("res://assets/particles/fire_particles.tscn");

# Ref to the interaction area of the wood
@onready var interaction_area: InteractionArea = $InteractionArea;

var tinder_number: int = 0;
var log_number: int = 0;

# The rocks that need to be moved in position
@onready var ROCKS := [
	{ "rock": $boulders/boulder_01_4k4, 	"position": Vector3(0.805, 0.015, 0.587) },
	{ "rock": $boulders/boulder_01_4k9, 	"position": Vector3(0.759, 0.001, -0.47) },
	{ "rock": $boulders/boulder_01_4k10,	"position": Vector3(0.338, 0.001, -0.891) },
	{ "rock": $boulders/boulder_01_4k7, 	"position": Vector3(-0.191, 0.001, -0.886) },
	{ "rock": $boulders/boulder_01_4k5,		"position": Vector3(-0.954, 0.001, 0.038) },
]

# Steps to start the fires
const FIRE_STEPS := [
	{ "id": "", 			"needed": "4", "text": "fix campfire", 				"fn": "move_rocks" },
	{ "id": "Tinder",		"needed": "6", "text": "place tinder",				"fn": "place_tinder" },
	{ "id": "Log",			"needed": "2", "text": "place log",					"fn": "place_log" },
	{ "id": "Oil Bottle",	"needed": "1", "text": "spread oil to the wood",	"fn": "spread_oil" },
	{ "id": "Lighter",		"needed": "1", "text": "light the fire",			"fn": "start_fire" }
];

# The progress of the current step
var step_progress := 0;
# The step currently in
var step_index: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect to the player item change signal
	player.inventory_changed.connect(player_item_changed);
	
	# Enable only when the player is carrying something relative to the fire
	interaction_area.set_enable(false);
	interaction_area.interaction = Callable(self, "try_interact");
	
	# Init set the state
	player_item_changed();

# Method called on player inventory change signal
func player_item_changed() -> void:
	# If all the steps are completed disable the campfire interaction
	if step_index >= FIRE_STEPS.size(): 
		interaction_area.set_enable(false);
		return;
	
	# The active step
	var step = FIRE_STEPS[step_index];
	# If the item in the player inventory is the item of the active step
	if player.item_name == step.id: 
		# Enable the interaction and set the text to the step's text
		interaction_area.interaction_text = step.text;
		interaction_area.set_enable(true);
	else:
		# Disable the area in any other case
		interaction_area.set_enable(false);

# Method called on interactions
func try_interact() -> void:
	# No interactions left
	if step_index >= FIRE_STEPS.size(): return;
	
	# The active step
	var step = FIRE_STEPS[step_index];
	# Double check that the correct item is on the player inventory
	if player.item_name != step.id: return;
	
	# Call the step's method
	call(step.fn);
	
	# Increment the step progess
	step_progress += 1;
	# If the needed amount of step progress is reached goto next step
	if step_progress >= int(step.needed):
		step_progress = 0;
		step_index += 1;
	
	# Reset the interactions UI
	player_item_changed();

func place_tinder() -> void:
	# Get the item from the player
	var item_path = player.pop_item();
	
	# Create a randoum rotation depending on the number of the item
	var y_rotation = rand_rot((tinder_number % 4) * 90, ((tinder_number % 4) * 90) + 90)
	# Give an incline to the tinder as more are placed
	var x_rotation = rand_rot(tinder_number * 1.2, (tinder_number * 1.8) + 5);
	# Place each tinder a bit above the previus one
	var y_position = tinder_number * 0.04;
	
	# Instantiate the wood
	var wood: PackedScene = load(item_path);
	var instance: Node3D = wood.instantiate();
	# Load values
	instance.rotation.y = y_rotation;
	instance.rotation.x = x_rotation;
	instance.position.y = y_position;
	
	# Increase the counter and add to screne
	tinder_number += 1;
	add_child(instance);
	
	# Disable the interactions of the tinder
	instance.remove_child(instance.get_node("InteractionArea"));

func place_log() -> void: 
	# Get the item from the player
	var item_path = player.pop_item();
	
	# Create a randoum rotation depending on the number of the item
	var y_rotation = rand_rot((log_number % 4) * 90, ((log_number % 4) * 90) + 90)
	# Give an incline to the tinder as more are placed
	var x_rotation = rand_rot(tinder_number * 1.2, (tinder_number * 1.8) + 5);
	# Place each tinder a bit above the previus one
	var y_position = (log_number * 0.04) + 0.2;
	
	# Instantiate the log
	var wood: PackedScene = load(item_path);
	var instance: Node3D = wood.instantiate();
	# Load values
	instance.rotation.y = y_rotation;
	instance.rotation.x = x_rotation;
	instance.position.y = y_position;
	
	# Increase the counter and add to screne
	log_number += 1;
	add_child(instance);
	
	# Disable the interactions of the log
	instance.remove_child(instance.get_node("InteractionArea"));

func move_rocks():
	# Get the boulder that needs to be moved right now
	var current_boulder = ROCKS[step_progress];
	# Chnage the position with tween for linear movement
	var tween = create_tween();
	tween.tween_property(
		current_boulder.rock,
		"position",
		current_boulder.position,
		.7
	);

func spread_oil():
	pass;
	
func start_fire():
	var fire_particles = fire_particles.instantiate();
	add_child(fire_particles);

func rand_rot(min_deg: float, max_deg: float) -> float:
	return deg_to_rad(randf_range(min_deg, max_deg));
