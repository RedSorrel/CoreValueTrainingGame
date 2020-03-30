extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var recipe_string
onready var lemonade_desc = get_node("VBoxContainer/Panel/LemonadeDesc")
onready var alert_label = get_node("SettingsContainer/LemonadeIngredients/AlertLabel")

onready var ratio_water = get_node("SettingsContainer/LemonadeIngredients/IngredientRatiosContainer/RatioContainerWater")
onready var ratio_lemon = get_node("SettingsContainer/LemonadeIngredients/IngredientRatiosContainer/RatioContainerLemon")
onready var ratio_sugar = get_node("SettingsContainer/LemonadeIngredients/IngredientRatiosContainer/RatioContainerSugar")

onready var item_water = get_node("SettingsContainer/LemonadeIngredients/IngredientSource/SourceWater")
onready var item_lemon = get_node("SettingsContainer/LemonadeIngredients/IngredientSource/SourceLemon")
onready var item_sugar = get_node("SettingsContainer/LemonadeIngredients/IngredientSource/SourceSugar")

onready var multiplier = 5 setget set_multiplier, get_multiplier
# Called when the node enters the scene tree for the first time.
func _ready():
	# connect the signal for when a ratio description has been changed by the player
	# when it is changed, update the string
	ratio_water.connect("selected", get_node("."), "update_lemonade_desc")
	ratio_lemon.connect("selected", get_node("."), "update_lemonade_desc")
	ratio_sugar.connect("selected", get_node("."), "update_lemonade_desc")
	
	#ratio_water.connect("change_consume_multiplier", get_node("."), "update_consume_multiplier")
	update_lemonade_desc()
	pass # Replace with function body.




func update_lemonade_desc() -> void:
	# called when one of the ratio option boxes has been changed
	# takes the updated Global recipe and updates the description string
	# call it in the ready function to have it set to the default options at the start of the page
	var recipe = Global.recipe
	recipe_string = "This lemonade batch is " + recipe["Water"].to_lower() + " with " + recipe["Lemon"].to_lower() + " and " + recipe["Sugar"].to_lower()
	lemonade_desc.text = recipe_string
	update_alert_label()
	
	

	
func update_alert_label() -> void:
	alert_label.text = "You can make a max of 0 gallons of lemonade.\n To make this amount\n" + str(ratio_water.get_ratio_multiplier()) + " water(s) \n" + str(ratio_lemon.get_ratio_multiplier())+ " lemon(s)\n" + str(ratio_sugar.get_ratio_multiplier()) + " sugar(s)\n will be used."

func set_multiplier(value) -> void:
	# Change the multiplier value
	# This value will determine how much of an item will be used
	# based on num gallons and the ratio description i.e. Watery = 3, Some water = 2, barely any = 1
	# This value will also determine if the player can mix this batch of lemonade
	# if this value is too high compared to the num of item(s) in stock then
	# disable the option, disable the mix button until the player changes it.
	
	# Get selected item id
	pass
	
func get_multiplier() -> int:
	return multiplier
	

func _on_LemonadeContainer_visibility_changed():
	#print("I've changed!")
	#print(Global.water_list[1].get_subtype() + "has " + str(Global.water_list[1].get_quantity()))
	#update_lemonade_desc()
	pass
	
func option_toggle() -> void:
	var selected_water = item_water.get_selected_item_text().to_lower()
	var selected_lemon 
	var selected_sugar 
	
	print("I'm running update desc now")
	for i in range(0, Global.water_list.size()):
		if Global.water_list[i].get_quantity() < multiplier:
			item_water.get_source_options().set_item_disabled(i, true)
		elif item_water.get_source_options().is_item_disabled(i):
			item_water.get_source_options().set_item_disabled(i, false)
			
	for i in range(0, Global.lemon_list.size()):
			if Global.lemon_list[i].get_quantity() < multiplier:
				item_lemon.get_source_options().set_item_disabled(i, true)
				
	for i in range(0, Global.sugar_list.size()):
			if Global.sugar_list[i].get_quantity() < multiplier:
				item_sugar.get_source_options().set_item_disabled(i, true)
