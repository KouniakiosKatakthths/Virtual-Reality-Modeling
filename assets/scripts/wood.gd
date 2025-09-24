extends Node3D
class_name Wood

# Get the player instance from the groups
@onready var player = get_tree().get_first_node_in_group("player") as Player;

# Ref to the interaction area of the wood
@onready var interaction_area: InteractionArea = $InteractionArea;
# An instance to the wood that is used
@export var wood_instance: String;
@export var wood_name: String;

func _ready() -> void:
	interaction_area.interaction = Callable(self, "wood_pickup");

func _process(_delta: float) -> void:
	# Disable interaction if the player is already carrying something
	interaction_area.set_enable(!player.carrying_item)

func wood_pickup() -> void:
	# Add the wood instance to the player inventory
	player.pickup_item(wood_instance, wood_name);

	# Delete this node
	queue_free();
