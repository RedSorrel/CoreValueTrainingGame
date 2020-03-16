extends VBoxContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var tap_water_debug = get_node("Debug/ColorRect/GridContainer/Waters")

onready var IngredientItem = preload("res://scenes/First Day/IngredientItem.gd")
onready var tap_water = IngredientItem.IngredientItem.new("water","tap water", 10)
onready var spring_water = IngredientItem.IngredientItem.new("water", "spring water", 0)
onready var bottled_water = IngredientItem.IngredientItem.new("water", "bottled water", 0)
onready var water_list = [tap_water, spring_water, bottled_water]

onready var lemon_mix = IngredientItem.IngredientItem.new("lemon", "lemonade mix", 0)
onready var lemon_juice = IngredientItem.IngredientItem.new("lemon", "lemon juice", 0)
onready var lemons = IngredientItem.IngredientItem.new("lemon", "fresh lemons", 0)
onready var lemon_list = [lemon_mix, lemon_juice, lemons]

onready var process_sugar = IngredientItem.IngredientItem.new("sugar", "processed sugar", 0)
onready var cane_sugar = IngredientItem.IngredientItem.new("sugar", "cane sugar", 0)
onready var stevia = IngredientItem.IngredientItem.new("sugar", "stevia", 0)
onready var sugar_list = [process_sugar, cane_sugar, stevia]

onready var purchase_btn = get_node("Button")
onready var water_source = get_node("GridContainer/WaterProductContainer/SourceOptions")
onready var water_quant = get_node("GridContainer/WaterProductContainer/Quantity")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print (tap_water.get_quantity())
	tap_water_debug.text = "# of tap waters = %s " % tap_water.get_quantity()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Button_pressed() -> void:
	purchase_items()
	tap_water_debug.text = "# of tap waters = %s"  % tap_water.get_quantity()
	
func purchase_items() -> void:
	# Read through the lists and their quantities
	# Add to the inventory on things > 0
	# Deduct money from the wallet 
	var index = water_source.get_selected_id()
	var quant = water_quant.get_value()
	for water in water_list:
		if (water.get_subtype().to_upper() == water_source.get_item_text(index).to_upper()):
			if (quant > 0):
				water.set_quantity(water.get_quantity() + quant)
			else:
				break
			print(water.get_subtype())
	
	for lemon in lemon_list:
		pass
	
