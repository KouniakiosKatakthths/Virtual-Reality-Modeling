extends CanvasLayer

# Get a ref to the item text label
@onready var item_text = $ItemInHand/ItemText;

# Update the item name text label
func update_inventory_item(item_name: String) -> void:
	item_text.text = item_name;
