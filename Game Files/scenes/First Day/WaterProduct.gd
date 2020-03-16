extends HBoxContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var label = get_node("Label").text
onready var option_box = get_node("SourceOptions")
onready var current_quantity = get_node("CurrentQuantity")
onready var price_label = get_node("Price")

onready var IngredientItem = preload("res://scenes/First Day/IngredientItem.gd")

onready var tap_water = IngredientItem.IngredientItem.new("water","tap water", 1, 10)
onready var spring_water = IngredientItem.IngredientItem.new("water", "spring water", 2, 0)
onready var bottled_water = IngredientItem.IngredientItem.new("water", "bottled water", 4, 0)
onready var water_list = [tap_water, spring_water, bottled_water]
onready var water_source = get_node("GridContainer/WaterProductContainer/SourceOptions")
onready var water_quant_box = get_node("GridContainer/WaterProductContainer/Quantity")
onready var water_price = get_node("GridContainer/WaterProductContainer/Price")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	populate_option_box()
	price_label.text = "Cost %s / unit" % tap_water.get_price()
	current_quantity.text = "Currently own %s" % tap_water.get_quantity()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func populate_option_box() -> void:
	option_box.add_item("Tap Water")
	option_box.add_item("Bottled Water")
	option_box.add_item("Spring Water")



func _on_SourceOptions_item_selected(id: int) -> void:
	# When selection is changed
	# Update the cost label
	# Update the current quantity label
	for water in water_list:
		if water.get_subtype().to_upper() == option_box.get_item_text(id).to_upper():
			price_label.text = "Cost %s / unit" % water.get_price()
			current_quantity.text = "Currently own %s" % water.get_quantity()
	print(option_box.get_item_text(id))
