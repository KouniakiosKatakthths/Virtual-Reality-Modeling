extends Node3D
class_name PickupItem

# Get the player instance from the groups
@onready var player = get_tree().get_first_node_in_group("player") as Player;

# Ref to the interaction area of the wood
@onready var interaction_area: InteractionArea = $InteractionArea;
# An instance to the wood that is used
@export var item_instance: String;
@export var item_name: String;

func _ready() -> void:
	interaction_area.interaction = Callable(self, "item_pickup");

func _process(_delta: float) -> void:
	# Disable interaction if the player is already carrying something
	interaction_area.set_enable(!player.carrying_item)

func item_pickup() -> void:
	# Add the item instance to the player inventory
	player.pickup_item(item_instance, item_name);

	# Delete this node
	queue_free();
