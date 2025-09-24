extends Area3D
class_name InteractionArea

# Interaction text shown in the HUD
@export var interaction_text: String = "Default Text";
# Interaction actions to be overritten
var interaction: Callable = func(): pass;
# The object can interact
var enable_interaction: bool = true;

func _on_body_entered(_body: Node3D) -> void:
	# Is the interactions for this object enabled
	if !enable_interaction: return;
	
	# Register the area as a valid interaction when the player enters
	InteractionManager.register_area(self);

func _on_body_exited(_body: Node3D) -> void:
	# Unregister the area when the player exits 
	InteractionManager.unregister_area(self);

func set_enable(interact: bool) -> void:
	enable_interaction = interact;
	
	# if a interaction disable is requested, remove the obj from the
	# interaction manager
	if !enable_interaction:
		InteractionManager.unregister_area(self);
