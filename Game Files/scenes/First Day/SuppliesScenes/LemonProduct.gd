extends HBoxContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var IngredientItem = preload("res://scenes/First Day/IngredientItem.gd")

onready var lemon_mix = IngredientItem.IngredientItem.new("lemon","lemonade mix", 1, 10)
onready var lemon_juice = IngredientItem.IngredientItem.new("lemon", "lemon juice concentrate", 2, 0)
onready var fresh_lemons = IngredientItem.IngredientItem.new("lemon", "fresh squeezed lemons", 4, 0)

onready var lemon_list = [lemon_mix, lemon_juice, fresh_lemons]

onready var source_label = get_node("Label").text
onready var option_box = get_node("SourceOptions")
onready var quant_box = get_node("Quantity")
onready var price_label = get_node("Price")

onready var current_quantity = get_node("CurrentQuantity")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	populate_option_box()
	price_label.text = "Cost %s / unit" % lemon_mix.get_price()
	current_quantity.text = "Currently own %s" % lemon_mix.get_quantity()


func populate_option_box() -> void:
	option_box.add_item("Lemonade Mix")
	option_box.add_item("Lemon Juice Concentrate")
	option_box.add_item("Fresh Squeezed Lemons")


func _on_SourceOptions_item_selected(id: int) -> void:
	# When selection is changed
	# Update the cost label
	# Update the current quantity label
	for lemon in lemon_list:
		if lemon.get_subtype().to_upper() == option_box.get_item_text(id).to_upper():
			price_label.text = "Cost %s / unit" % lemon.get_price()
			current_quantity.text = "Currently own %s" % lemon.get_quantity()
			print(lemon.get_subtype())
			print(lemon.get_quantity())
