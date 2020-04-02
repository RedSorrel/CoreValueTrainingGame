extends CanvasItem

	
onready var product_list setget set_list, get_list
onready var option_box = get_node("SourceOptions")
onready var label = get_node("Label")
onready var source_options = get_node("SourceOptions")
onready var quantity = get_node("CurrentQuantity")
onready var buffs = get_node("Buffs")
onready var multiplier = 1
# Goal: To extend the source item class to run most everything
	# and the children classes pass an array value to it

func _on_SourceOptions_item_selected(id: int) -> void:
	quantity.text = "Currently Have: %s" % product_list[id].get_quantity()
	
	
func set_list(array) -> void:
	product_list = array
	
func get_list() -> Array:
	return product_list
	
func set_source_components(product_list) -> void:
	self.product_list = product_list
	Global.populate_option_box(self.product_list, option_box)
	quantity.text = "Currently Have: %s" % self.product_list[0].get_quantity()
	
func get_selected_item_text() -> String:
	return option_box.get_item_text(option_box.get_selected_id())
# TODO Code for displaying buffs	

func get_selected_id() -> int:
	return option_box.get_item_id()
	
func get_source_options() -> Node:
	return source_options

func option_toggle(multiplier) -> void:
	# Check to see if the number of items the player has in stock
	# for each item is lower than the multiplier.
	# Disable that option if it is less than
	# otherwise, reenable it
	# will be called when switching scenes
	# in case the player has bought more items
	# player shouldn't be able to use items that they don't have enough of
	# multiplier will be based on number of gallons selected and the ratio
	# of each item (Watery = 3x water choice * num gallons)
	for i in range(0, product_list.size()):
		if product_list[i].get_quantity() < multiplier:
			source_options.set_item_disabled(i, true)
		elif source_options.is_item_disabled(i):
			source_options.set_item_disabled(i, false)

func child_ready(product_list) -> void:
	# consolidate functions that will be called in children scripts
	# into one and just pass the product_list argument down
	set_source_components(product_list)
	#option_toggle(Global.get_multiplier())
	option_toggle(self.multiplier)


func _on_SourceOptions_visibility_changed():
	# Visibility will be changed when player chooses one of the buttons
	# in the main scene (Overview, Lemonade, Supplies).
	# Update only when Lemonade button gets pushed and the parent container
	# that houses these scenes becomes visible
	
	# Update the quantity text
	quantity.text = "Currently Have %s" % product_list[source_options.get_selected()].get_quantity()
	if self.is_visible():
		#option_toggle(Global.get_multiplier())
		option_toggle(multiplier)

func set_multiplier(value) -> void:
	self.multiplier = value
	
func get_multiplier() -> int:
	return self.multiplier
	
func call_option_toggle() -> void:
	option_toggle(self.get_multiplier())
