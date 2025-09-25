extends Node3D

# Get the player instance from the groups
@onready var player = get_tree().get_first_node_in_group("player") as Player;

# Ref to the interaction area of the wood
@onready var interaction_area: InteractionArea = $InteractionArea;

var tinder_number: int = 0;
var log_number: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Enable only when the player is carrying something relative to the fire
	interaction_area.set_enable(false);
	interaction_area.interaction = Callable(self, "place_wood");

func _process(_delta: float) -> void:
	# If the player is carrying one of the acceptible objects set the appropriate message
	if player.item_name == "tinder" && tinder_number < 6:
		interaction_area.interaction_text = "place tinder";
		interaction_area.set_enable(true);
	elif player.item_name == "log" && tinder_number == 6 && log_number < 2:
		# Place logs only when all 6 tinder have been placed
		interaction_area.interaction_text = "place log";
		interaction_area.set_enable(true);
	elif player.item_name == "lighter" && tinder_number == 6 && log_number == 2:
		interaction_area.interaction_text = "light the fire";
		interaction_area.set_enable(true);
	else:
		# Player is carrying something else that is not used for fire
		interaction_area.set_enable(false);
	
func place_wood() -> void:
	if tinder_number < 6:
		place_tinder();
	elif log_number < 2:
		place_log();

func place_tinder():
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

func place_log():
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

func rand_rot(min_deg: float, max_deg: float) -> float:
	return deg_to_rad(randf_range(min_deg, max_deg));
