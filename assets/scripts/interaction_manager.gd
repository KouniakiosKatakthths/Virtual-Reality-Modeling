extends Node3D

# Get the player instance from the groups
@onready var player = get_tree().get_first_node_in_group("player");
@onready var interaction_ui: Label = $Label;

# Default text that shows on every interaction
const base_text = "Press [e] to "

# All the interactive areas that the player is into
var active_areas: Array[InteractionArea] = [];
# Flag that determines if the manager dosn't handle an interaction
var can_interact: bool = true;

# Add a new interaction area to the manager
func register_area(area: InteractionArea) -> void:
	active_areas.push_back(area);
	
# Remove an interaction area from the manager
func unregister_area(area: InteractionArea) -> void:
	var index = active_areas.find(area);
	if index == -1: return;
	
	active_areas.remove_at(index);

func _process(_delta: float) -> void:
	# Interaction areas have been added and the manager isn't handling any interaction
	if active_areas.size() > 0 && can_interact:
		# Find the closest to the player
		active_areas.sort_custom(sort_by_player_distance);
		
		interaction_ui.text = base_text + active_areas[0].interaction_text;
		interaction_ui.show();
	else:
		interaction_ui.hide();
		

func sort_by_player_distance(area1: InteractionArea, area2: InteractionArea) -> bool:
	var dis_a1 = player.global_position.distance_to(area1.global_position);
	var dis_a2 = player.global_position.distance_to(area2.global_position);
	return dis_a1 < dis_a2;
	
func _input(event: InputEvent) -> void:
	# The interaction action isn't selected
	if !event.is_action_pressed("interact"): return;
	
	# No interaction objs exist or the manager is handling an interaction already
	if active_areas.size() == 0 || !can_interact: return;
	
	# Hide the ui as the interaction is been handled
	can_interact = false;
	interaction_ui.hide();
	
	# Handle the interaction
	await active_areas[0].interaction.call();
	
	can_interact = true;
