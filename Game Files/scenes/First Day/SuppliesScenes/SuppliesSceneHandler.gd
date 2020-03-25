extends VBoxContainer

onready var tap_water_debug = get_node("Debug/ColorRect/GridContainer/Waters")
onready var lemon_debug = get_node("Debug/ColorRect/GridContainer/Lemons")
onready var sugar_debug = get_node("Debug/ColorRect/GridContainer/Sugars")
onready var cup_debug = get_node("Debug/ColorRect/GridContainer/Cups")

onready var water_product_container = get_node("GridContainer/WaterProductContainer")
onready var water_list = water_product_container.product_list
onready var water_source = water_product_container.option_box
onready var water_quant_box = water_product_container.quant_box
onready var water_price = water_product_container.current_quantity
onready var water_current_quant = get_node("GridContainer/WaterProductContainer/CurrentQuantity")

onready var lemon_product_container = get_node("GridContainer/LemonProductContainer")
onready var lemon_list = lemon_product_container.product_list
onready var lemon_source = lemon_product_container.option_box
onready var lemon_quant_box = lemon_product_container.quant_box
onready var lemon_current_quant = lemon_product_container.current_quantity

onready var sugar_product_container = get_node("GridContainer/SugarProductContainer")
onready var sugar_list = sugar_product_container.product_list
onready var sugar_source = sugar_product_container.option_box
onready var sugar_quant_box = sugar_product_container.quant_box
onready var sugar_current_quant = sugar_product_container.current_quantity

onready var cup_product_container = get_node("GridContainer/CupProductContainer")
onready var cup_list = cup_product_container.product_list
onready var cup_source = cup_product_container.option_box
onready var cup_quant_box = cup_product_container.quant_box
onready var cup_current_quant = cup_product_container.current_quantity


onready var cost_label = get_node("TotalCost")
onready var cost = cup_product_container.get_subtotal()
onready var purchase_btn = get_node("Button")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#tap_water_debug.text = "# of tap waters = %s " % tap_water.get_quantity()
	#tap_water_debug.text = "# of tap waters = %s " % water_product_container.tap_water.get_quantity()
	tap_water_debug.text = "# of tap waters = %s " % Global.tap_water.get_quantity()
	get_node("GridContainer/CupProductContainer").connect("quantity_changed", get_node("."), "update_total_string")
	get_node("GridContainer/LemonProductContainer").connect("quantity_changed", get_node("."), "update_total_string")
	get_node("GridContainer/WaterProductContainer").connect("quantity_changed", get_node("."), "update_total_string")
	get_node("GridContainer/SugarProductContainer").connect("quantity_changed", get_node("."), "update_total_string")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Button_pressed() -> void:
	purchase_items()
	tap_water_debug.text = "# of tap waters = %s"  % Global.tap_water.get_quantity()
	lemon_debug.text = "# of lemons = %s" % Global.lemon_mix.get_quantity()
	sugar_debug.text = "# of sugars = %s" % Global.process_sugar.get_quantity()
	cup_debug.text = "# of cups = %s" % Global.paper_cup.get_quantity()
	
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
				water_current_quant.text = "Currently own: %s" % water.get_quantity()
			else:
				break
	
	for lemon in lemon_list:
		if (lemon.get_subtype().to_upper() == lemon_source.get_item_text(l_index).to_upper()):
			if (lemon_quant > 0):
				lemon.set_quantity(lemon.get_quantity() + lemon_quant)
				lemon_current_quant.text = "Currently own: %s" % lemon.get_quantity()
			else:
				break
			
	
	for sugar in sugar_list:
		if (sugar.get_subtype().to_upper() == sugar_source.get_item_text(s_index).to_upper()):
			if (sugar_quant > 0):
				sugar.set_quantity(sugar.get_quantity() + sugar_quant)
				sugar_current_quant.text = "Currently own: %s" % sugar.get_quantity()
			else:
				break
			
			
	for cup in cup_list:
		if (cup.get_subtype().to_upper() == cup_source.get_item_text(c_index).to_upper()):
			if (cup_quant > 0):
				cup.set_quantity(cup.get_quantity() + cup_quant)
				cup_current_quant.text = "Currently own: %s" % cup.get_quantity()
			else:
				break
	

func calculate_total() -> int:
	return sugar_product_container.get_subtotal() + lemon_product_container.get_subtotal() + water_product_container.get_subtotal() + cup_product_container.get_subtotal()
	
func update_total_string() -> void:
	cost_label.text = "Total cost of these items is: $%s" % calculate_total()
	


