extends VBoxContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var tap_water_debug = get_node("Debug/ColorRect/GridContainer/Waters")
onready var lemon_debug = get_node("Debug/ColorRect/GridContainer/Lemons")
onready var sugar_debug = get_node("Debug/ColorRect/GridContainer/Sugars")
onready var cup_debug = get_node("Debug/ColorRect/GridContainer/Cups")

onready var IngredientItem = preload("res://scenes/First Day/IngredientItem.gd")

onready var tap_water = IngredientItem.IngredientItem.new("water","tap water", 1, 10)
onready var spring_water = IngredientItem.IngredientItem.new("water", "spring water", 2, 0)
onready var bottled_water = IngredientItem.IngredientItem.new("water", "bottled water", 4, 0)
onready var water_list = [tap_water, spring_water, bottled_water]
onready var water_source = get_node("GridContainer/WaterProductContainer/SourceOptions")
onready var water_quant_box = get_node("GridContainer/WaterProductContainer/Quantity")
onready var water_price = get_node("GridContainer/WaterProductContainer/Price")


onready var lemon_mix = IngredientItem.IngredientItem.new("lemon", "lemonade mix", 0, 0)
onready var lemon_juice = IngredientItem.IngredientItem.new("lemon", "lemon juice", 0, 0)
onready var lemons = IngredientItem.IngredientItem.new("lemon", "fresh lemons", 0, 0)
onready var lemon_list = [lemon_mix, lemon_juice, lemons]
onready var lemon_source = get_node("GridContainer/LemonProductContainer/SourceOptions")
onready var lemon_quant_box = get_node("GridContainer/LemonProductContainer/Quantity")

onready var process_sugar = IngredientItem.IngredientItem.new("sugar", "processed sugar", 0, 0)
onready var cane_sugar = IngredientItem.IngredientItem.new("sugar", "cane sugar", 0, 0)
onready var stevia = IngredientItem.IngredientItem.new("sugar", "stevia", 0, 0)
onready var sugar_list = [process_sugar, cane_sugar, stevia]
onready var sugar_source = get_node("GridContainer/SugarProductContainer/SourceOptions")
onready var sugar_quant_box = get_node("GridContainer/SugarProductContainer/Quantity")

onready var paper_cup = IngredientItem.IngredientItem.new("cup", "paper cups", 0, 0)
onready var plastic_cup = IngredientItem.IngredientItem.new("cup", "plastic cups", 0, 0)
onready var branded_cup = IngredientItem.IngredientItem.new("cup", "branded cups", 0, 0)
onready var cup_list = [paper_cup, plastic_cup, branded_cup]
onready var cup_source = get_node("GridContainer/CupProdcutContainer/SourceOptions")
onready var cup_quant_box = get_node("GridContainer/CupProdcutContainer/Quantity")

onready var cost_label = get_node("TotalCost")

onready var purchase_btn = get_node("Button")

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
	lemon_debug.text = "# of lemons = %s" % lemon_mix.get_quantity()
	sugar_debug.text = "# of sugars = %s" % process_sugar.get_quantity()
	cup_debug.text = "# of cups = %s" % paper_cup.get_quantity()
	# Reset spinboxes back to 0
	lemon_quant_box.set_value(0)
	water_quant_box.set_value(0)
	cup_quant_box.set_value(0)
	sugar_quant_box.set_value(0)
func purchase_items() -> void:
	# Read through the lists and their quantities
	# Add to the inventory on things > 0
	# Deduct money from the wallet 
	var w_index = water_source.get_selected_id()
	var water_quant = water_quant_box.get_value()
	
	var l_index = lemon_source.get_selected_id()
	var lemon_quant = lemon_quant_box.get_value()
	
	var s_index = sugar_source.get_selected_id()
	var sugar_quant = sugar_quant_box.get_value()
	
	var c_index = cup_source.get_selected_id()
	var cup_quant = cup_quant_box.get_value()
	
	for water in water_list:
		if (water.get_subtype().to_upper() == water_source.get_item_text(w_index).to_upper()):
			if (water_quant > 0):
				water.set_quantity(water.get_quantity() + water_quant)
			else:
				break
			print(water.get_subtype())
	
	for lemon in lemon_list:
		if (lemon.get_subtype().to_upper() == lemon_source.get_item_text(l_index).to_upper()):
			if (lemon_quant > 0):
				lemon.set_quantity(lemon.get_quantity() + lemon_quant)
			else:
				break
			print(lemon.get_subtype())
	
	for sugar in sugar_list:
		if (sugar.get_subtype().to_upper() == sugar_source.get_item_text(s_index).to_upper()):
			if (sugar_quant > 0):
				sugar.set_quantity(sugar.get_quantity() + sugar_quant)
			else:
				break
			print(sugar.get_subtype())
			
	for cup in cup_list:
		if (cup.get_subtype().to_upper() == cup_source.get_item_text(c_index).to_upper()):
			if (cup_quant > 0):
				cup.set_quantity(cup.get_quantity() + cup_quant)
			else:
				break
			print(cup.get_subtype())
	
