extends Node

	
onready var product_list setget set_list, get_list
onready var option_box = get_node("SourceOptions")
onready var label = get_node("Label")
onready var source_options = get_node("SourceOptions")
onready var quantity = get_node("CurrentQuantity")
onready var buffs = get_node("Buffs")


# Goal: To extend the source item class to run most everything
	# and the children classes pass an array value to it
	
func _on_SourceOptions_item_selected(id: int) -> void:
	quantity.text = "Currently Have: %s" % product_list[id].get_quantity()
	print(product_list[id].get_quantity())

func set_list(array) -> void:
	product_list = array
	
func get_list() -> Array:
	return product_list
	
func set_source_components(product_list) -> void:
	self.product_list = product_list
	Global.populate_option_box(self.product_list, option_box)
	quantity.text = "Currently Have: %s" % self.product_list[0].get_quantity()
	
	
# TODO Code for displaying buffs	

