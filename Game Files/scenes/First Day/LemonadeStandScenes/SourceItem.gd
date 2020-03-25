extends Node


onready var option_box = get_node("SourceOptions")
onready var product_list = Global.lemon_list
onready var label = get_node("Label")
onready var source_options = get_node("SourceOptions")
onready var quantity = get_node("CurrentQuantity")
onready var buffs = get_node("Buffs")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Global.populate_option_box(product_list, option_box)
	#Quantity.text = "Quantity: %s" % product_list[0].get_quantity()
	print("A")


func _on_SourceOptions_item_selected(id: int) -> void:
	quantity.text = "Quantity: %s" % product_list[id].get_quantity()
	print(product_list[id].get_quantity())

	# TODO Code for displaying buffs	

func set_list(array:Array) -> void:
	product_list = array
