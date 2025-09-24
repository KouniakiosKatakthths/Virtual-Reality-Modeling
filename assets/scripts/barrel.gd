extends Node3D

# Ref to the interaction area of the barrel
@onready var interaction_area: InteractionArea = $InteractionArea;

var barrel_wood_1 = preload("res://assets/prefabs/fireplace objects/barrel_wood_2.tscn")
var barrel_wood_2 = preload("res://assets/prefabs/fireplace objects/barrel_wood_2.tscn");

# The two meshes for the state of the barrel
@onready var barrel_complete = $BarrelComplete;
@onready var barrel_removed = $BarrelRemoved;

var radius: float = 0.3;
var removed: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interaction = Callable(self, "get_wood");

func get_wood():
	# Show the destroyed barrel model
	barrel_complete.hide();
	barrel_removed.show();
	# Disable the interaction
	interaction_area.set_enable(false);
	
	# Spawn wood in random locations around the barrel
	spawn_wood(barrel_wood_1);
	spawn_wood(barrel_wood_1);
	spawn_wood(barrel_wood_1);
	spawn_wood(barrel_wood_2);
	spawn_wood(barrel_wood_2);
	spawn_wood(barrel_wood_2);

func spawn_wood(object: PackedScene):
	var instance = object.instantiate();
	
	# A random angle
	var angle = randf() * TAU;
	# A random distance that is greater than 1
	var distance = 1 + (randf() * radius);
	# Offset
	var offset = Vector3(cos(angle), 0, sin(angle)) * distance;
	
	instance.position = Vector3.ZERO + offset;
	add_child(instance);
