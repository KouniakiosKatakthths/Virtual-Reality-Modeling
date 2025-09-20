extends CharacterBody3D

# Head obj ref
@onready var head = $Head;

# Standing collitions refs
@onready var standing_collition = $standing_collition;
@onready var sneak_collition = $sneak_collition;
# Raycast for detectiong if the player can stand up
@onready var standing_raycast = $RayCast3D;

@export var mouse_sens = 0.25;
@export var walking_speed = 5.0;
@export var sprinting_speed = 8.0;
@export var sneaking_speed = 1.7;
@export var sneaking_depth = -0.5;
@export var jump_velocity = 4.5;

var lerp_speed = 10.0;
var current_speed = 5.0;

var direction = Vector3.ZERO;

func _ready() -> void:
	# Lock the mouse to the center
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);

func _input(event: InputEvent) -> void:
	# Capture mouse movement event
	if event is InputEventMouseMotion:
		# Rotate body around
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens));
		# Rotate head up and down
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens));
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-90), deg_to_rad(90));

func _physics_process(delta: float) -> void:
	
	# Update player speed
	handle_movement_state(delta);
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the player movement 
	var input_dir := Input.get_vector("left", "right", "forwards", "backwards");
	# Applay a more liniear acceleration and decaleration
	direction = lerp(
		direction,
		(transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(),
		delta * lerp_speed
	);
	
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()

func handle_movement_state(delta: float):
	# Set the speed of the player depending on the selected action
	if Input.is_action_pressed("sneak"):
		current_speed = sneaking_speed;
		# Depress the position of the head in a smooth linear way
		head.position.y = lerp(head.position.y, 1.7 + sneaking_depth, delta * lerp_speed);
		# Enable sneak collition and disable standing collition
		standing_collition.disabled = true;
		sneak_collition.disabled = false;
	elif !standing_raycast.is_colliding():			# Entity can stand up
		# Restore head position in a linear way
		head.position.y = lerp(head.position.y, 1.7, delta * lerp_speed);;
		
		# Enable standing collition and sneak standing collition
		standing_collition.disabled = false;
		sneak_collition.disabled = true;
		
		if Input.is_action_pressed("sprint"):
			current_speed = sprinting_speed;
		else:
			current_speed = walking_speed;	
