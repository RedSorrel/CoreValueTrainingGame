extends Node
#signal my_signal
signal quantity_changed 

onready var source_label = get_node("Label").text
onready var option_box = get_node("SourceOptions")
onready var price_label = get_node("Price")
onready var current_quantity = get_node("CurrentQuantity")
onready var quant_box = get_node("Quantity")
onready var product_list setget set_list
onready var subtotal = 0 setget , get_subtotal
onready var sub_price = 0
onready var image: TextureRect = get_node("TextureRect")
onready var img_array = ["res://assets/images/random_event_wallet.jpg"]
onready var dummyIng = Global.IngredientItem.IngredientItem.new("dummy", "dummy", 0, 0)

func _ready() -> void:
	
	if not product_list == null:
		Global.populate_option_box(product_list, option_box)
	
func populate_option_box() -> void:
	for product in product_list:
		option_box.add_item(product.get_subtype().capitalize())
	current_quantity.text = "Currently own %s" % product_list[0].get_quantity()
	price_label.text = "Cost $%s / unit" % product_list[0].get_price()
	
func _on_SourceOptions_item_selected(id: int) -> void:
	# When selection is changed
	# Update the cost label
	# Update the current quantity label
	for product in product_list:
		if product.get_subtype().to_upper() == option_box.get_item_text(id).to_upper():
			sub_price = product.get_price()
			price_label.text = "Cost $%s / unit" % sub_price
			current_quantity.text = "Currently own %s" % product.get_quantity()
	
	# Show product image
	display_image(img_array, id)
	
	# Update total price with price of newly selected item
	# and current quantity
	# Send it to supply info container to handle the total string
	calculate_subtotal(quant_box.value)	
	emit_signal("quantity_changed")


func _on_Quantity_value_changed(value: float) -> void:
	# On change, calculate the subtotal price of this product
	# Send it to the supply info container to handle it
	calculate_subtotal(value)
	emit_signal("quantity_changed")
	
	
func get_subtotal() -> int:
	return subtotal
	
	
func set_list(array) -> void:
	product_list = array
	
func calculate_subtotal(value) -> int:
	sub_price = product_list[option_box.get_selected_id()].get_price()
	subtotal = sub_price * int(value)
	return subtotal


func _on_SuppliesItemContainer_visibility_changed():
	current_quantity.text = "Currently own %s" % product_list[0].get_quantity()
	display_image(img_array, 0)

func display_image(array:Array, index: int) -> void:
	# Use the selected item in the source option to display an image
	# related to that item from an array holding image locations
	if array.size() - 1 >= index:
		# if the image array is about the same length as the sources items
		# use the index to display the image at that index
		image.set_texture(load(array[index]))
	elif array.size() == 1:
		# Otherwise only use the first image in the array
		image.set_texture(load(array[0]))
