extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var IngredientItem = preload("res://scenes/First Day/IngredientItem.gd")

onready var source_label = get_node("Label").text
onready var option_box = get_node("SourceOptions")
onready var quant_box = get_node("Quantity")
onready var price_label = get_node("Price")
onready var current_quantity = get_node("CurrentQuantity")
onready var product_list
onready var subtotal
onready var sub_price
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	populate_option_box()
	price_label.text = "Cost $%s / unit" % product_list[0].get_price()
	current_quantity.text = "Currently own %s" % product_list[0].get_quantity()

func populate_option_box() -> void:
	# option_box.additem("Item Name")
	for product in product_list:
		option_box.add_item(product.get_subtype())
	
func _on_SourceOptions_item_selected(id: int) -> void:
	# When selection is changed
	# Update the cost label
	# Update the current quantity label
	for product in product_list:
		if product.get_subtype().to_upper() == option_box.get_item_text(id).to_upper():
			sub_price = product.get_price()
			price_label.text = "Cost $%s / unit" % sub_price
			current_quantity.text = "Currently own %s" % product.get_quantity()
			


func _on_Quantity_value_changed(value: float) -> void:
	# On change, calculate the subtotal price of this product
	# Send it higher to be displayed before purchase
	subtotal = calculate_subtotal(sub_price , value)
	
	
func calculate_subtotal(price, quant) -> int:
	return price * int(quant)
