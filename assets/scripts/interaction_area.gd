extends Area3D
class_name InteractionArea

# Interaction text shown in the HUD
@export var interaction_text: String = "Default Text";
# Interaction actions to be overritten
var interaction: Callable = func(): pass;


func _on_body_entered(body: Node3D) -> void:
	# Register the area as a valid interaction when the player enters
	InteractionManager.register_area(self);


func _on_body_exited(body: Node3D) -> void:
	# Unregister the area when the player exits 
	InteractionManager.unregister_area(self);
