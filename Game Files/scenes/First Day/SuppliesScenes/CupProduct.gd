extends HBoxContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var IngredientItem = preload("res://scenes/First Day/IngredientItem.gd")

onready var paper_cup = IngredientItem.IngredientItem.new("cup", "paper cups", 1, 0)
onready var plastic_cup = IngredientItem.IngredientItem.new("cup", "plastic cups", 2, 0)
onready var branded_cup = IngredientItem.IngredientItem.new("cup", "branded cups", 4, 0)
onready var cup_list = [paper_cup, plastic_cup, branded_cup]
onready var source_label = get_node("Label").text
onready var option_box = get_node("SourceOptions")
onready var quant_box = get_node("Quantity")
onready var price_label = get_node("Price")
onready var current_quantity = get_node("CurrentQuantity")
onready var subtotal
onready var sub_price
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	populate_option_box()
	print(cup_list)
	price_label.text = "Cost %s / unit" % paper_cup.get_price()
	current_quantity.text = "Currently own %s" % paper_cup.get_quantity()

func populate_option_box() -> void:
	option_box.add_item("Paper Cups")
	option_box.add_item("Plastic Cups")
	option_box.add_item("Branded Cups")
	

func _on_SourceOptions_item_selected(id: int) -> void:
	# When selection is changed
	# Update the cost label
	# Update the current quantity label
	for cup in cup_list:
		if cup.get_subtype().to_upper() == option_box.get_item_text(id).to_upper():
			sub_price = cup.get_price()
			price_label.text = "Cost %s / unit" % sub_price
			current_quantity.text = "Currently own %s" % cup.get_quantity()
			


func _on_Quantity_value_changed(value: float) -> void:
	# On change, calculate the subtotal price of this product
	# Send it higher to be displayed before purchase
	subtotal = calculate_subtotal(sub_price , value)
	
	
func calculate_subtotal(price, quant) -> int:
	return price * int(quant)
