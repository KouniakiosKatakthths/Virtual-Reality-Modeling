extends CharacterBody3D

@export var mouse_sens = 0.4;

@export var m_walking_speed = 5.0;
@export var m_sprinting_speed = 8.0;

@export var m_jump_velocity = 4.5;

var m_current_speed;

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	# Set the player speed to running if the running input is active
	m_current_speed = m_sprinting_speed if Input.is_action_pressed("sprint") else m_walking_speed;
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = m_jump_velocity

	# Get the input direction and handle the player movement 
	var input_dir := Input.get_vector("left", "right", "forwards", "backwards");
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * m_current_speed
		velocity.z = direction.z * m_current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, m_current_speed)
		velocity.z = move_toward(velocity.z, 0, m_current_speed)

	move_and_slide()
