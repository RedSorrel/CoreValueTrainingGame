extends HBoxContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var IngredientItem = preload("res://scenes/First Day/IngredientItem.gd")

onready var process_sugar = IngredientItem.IngredientItem.new("sugar", "processed sugar", 1, 10)
onready var cane_sugar = IngredientItem.IngredientItem.new("sugar", "cane sugar", 2, 0)
onready var stevia = IngredientItem.IngredientItem.new("sugar", "stevia", 4, 0)
onready var sugar_list = [process_sugar, cane_sugar, stevia]
onready var source_label = get_node("Label").text
onready var option_box = get_node("SourceOptions")
onready var quant_box = get_node("Quantity")
onready var price_label = get_node("Price")
onready var current_quantity = get_node("CurrentQuantity")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	populate_option_box()
	print(sugar_list)
	price_label.text = "Cost %s / unit" % process_sugar.get_price()
	current_quantity.text = "Currently own %s" % process_sugar.get_quantity()

func populate_option_box() -> void:
	option_box.add_item("Processed Sugar")
	option_box.add_item("Cane Sugar")
	option_box.add_item("Stevia")
	

func _on_SourceOptions_item_selected(id: int) -> void:
	# When selection is changed
	# Update the cost label
	# Update the current quantity label
	for sugar in sugar_list:
		if sugar.get_subtype().to_upper() == option_box.get_item_text(id).to_upper():
			price_label.text = "Cost %s / unit" % sugar.get_price()
			current_quantity.text = "Currently own %s" % sugar.get_quantity()
			print(sugar.get_subtype())
			print(sugar.get_quantity())
