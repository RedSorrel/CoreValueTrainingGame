extends HBoxContainer

signal price_changed(value)

onready var MAX_GALLONS = 5
onready var recipe_string
onready var lemonade_desc = get_node("VBoxContainer/Panel/LemonadeDesc")
onready var alert_label = get_node("SettingsContainer/LemonadeIngredients/AlertLabel")
onready var not_enough_label = get_node("SettingsContainer/LemonadeIngredients/NotEnoughLabel")
onready var exeeds_cup_label = get_node("SettingsContainer/LemonadeIngredients/ExceedCupsLabel")
onready var mix_button = get_node("SettingsContainer/LemonadeIngredients/ButtonMixLemonade")

onready var ratio_water = get_node("SettingsContainer/LemonadeIngredients/IngredientRatiosContainer/RatioContainerWater")
onready var ratio_lemon = get_node("SettingsContainer/LemonadeIngredients/IngredientRatiosContainer/RatioContainerLemon")
onready var ratio_sugar = get_node("SettingsContainer/LemonadeIngredients/IngredientRatiosContainer/RatioContainerSugar")
onready var ratios = [ratio_water, ratio_lemon, ratio_sugar]

onready var item_water = get_node("SettingsContainer/LemonadeIngredients/IngredientSource/SourceWater")
onready var item_lemon = get_node("SettingsContainer/LemonadeIngredients/IngredientSource/SourceLemon")
onready var item_sugar = get_node("SettingsContainer/LemonadeIngredients/IngredientSource/SourceSugar")
onready var items = [item_water, item_lemon, item_sugar]

onready var gallon_node = get_node("SettingsContainer/LemonadeIngredients/HBoxContainer/Gallons")
onready var lemonade_price = 1.00 setget set_price, get_price
onready var current_price_label = get_node("SettingsContainer/LemonadeIngredients/PriceAdjustContainer/CurrentPriceLabel")
onready var lemonade_new_price = get_node("SettingsContainer/LemonadeIngredients/PriceAdjustContainer/AdjustPrice")

onready var gallons_of_lemonade = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	# connect the signal for when a ratio description has been changed by the player
	# when it is changed, update the string
	ratio_water.connect("selected", get_node("."), "update_general")
	ratio_lemon.connect("selected", get_node("."), "update_general")
	ratio_sugar.connect("selected", get_node("."), "update_general")
	
	ratio_water.connect("selected", item_water, "call_option_toggle")
	ratio_lemon.connect("selected", item_lemon, "call_option_toggle")
	ratio_sugar.connect("selected", item_sugar, "call_option_toggle")
	

	#ratio_water.connect("change_consume_multiplier", get_node("."), "update_consume_multiplier")
	update_general()
	set_multipliers(gallon_node.value)




func update_lemonade_desc() -> void:
	# Update the recipe display text
	var recipe = Global.recipe
	recipe_string = "This lemonade batch is " + recipe["Water"].to_lower() + " with " + recipe["Lemon"].to_lower() + " and " + recipe["Sugar"].to_lower()
	lemonade_desc.text = recipe_string
	
	
	
func update_general() -> void:
	# This was made because I was stuffing too many calls into one function
	# didn't make sense, so breaking it up and putting it in here.
	# called when ratio option boxes or gallon spin box have been changed
	# to display relevant text such as the recipe change,
	# how much lemonade the player can make
	# and updating multipliers
	
	alert_player_cup_limit()
	update_lemonade_desc()
	update_alert_label()
	set_multipliers(gallon_node.value)
	
	# Disable the button if the player lacks resources
	# to create the recipe with ingredients and number of gallons
	for i in items:
		i.call_option_toggle()
		if i.source_options.is_item_disabled(i.source_options.get_selected_id()):
			# Disable the mix button
			# Alert the player
			mix_button.disabled = true
			not_enough_label.visible = true
			not_enough_label.add_color_override("font_color", Color(1, 0.5, 0.5))
		else:
			# Enable the mix button
			# Hide the alert (not enough items)
			mix_button.disabled = false
			not_enough_label.visible = false
	
func update_alert_label() -> void:
	alert_label.text = "You currently have " + str(gallons_of_lemonade)+ " gallons of lemonade made.\n To make this amount\n" + str(ratio_water.get_ratio_multiplier() * gallon_node.value) + " water(s) \n" + str(ratio_lemon.get_ratio_multiplier() * gallon_node.value) + " lemon(s)\n" + str(ratio_sugar.get_ratio_multiplier() * gallon_node.value) + " sugar(s)\n will be used."


func set_multipliers(gallons) -> void:
	# update the multipliers in case anything has changed
	for i in range(0, ratios.size()):
		items[i].set_multiplier(ratios[i].get_ratio_multiplier() * gallons)


func _on_Gallons_value_changed(value):
	# For each item type, loop through and call option toggle
	# in order to check and disable / renable items in the drop down box
	update_general()
	


func _on_SetPriceButton_pressed():
	# Get the price in the spinbox AdjustPrice
	# Set the price to this new price
	# Update the Current price label
	# Send this info to the simulation or global
	set_price(lemonade_new_price.value)
	update_price_string()
	
	# Send the price to the simulation so it can update
	# the price of lemonade there
	emit_signal("price_changed", get_price())
	pass # Replace with function body.

func update_price_string() -> void:
	current_price_label.text = "Current price / cup of lemonade: $%.*f" % [2, get_price()]
	pass
		
func set_price(value:float) -> void:
	lemonade_price = value
	
func get_price() -> float: 
	return lemonade_price


func _on_ButtonMixLemonade_pressed():
	# When this button is pressed
	# Make Lemonade if the following conditions are met
	# The player has enough resources to make the lemonade with the recipe and sources chosen
	# and the number of gallons they have chosen is valid
	# I.e. they have enough resources to make this lemonade
	# Save the amount of lemonade made to a variable
	# print(item_water.product_list[0].get_quantity())
	# item_water.product_list[0].set_quantity(item_water.prduct_list[0].get_quantity() - item_water.get_multiplier())
	
	# Deduct (multiplier) many items from the quantity from each item
	# and update the string to display the changes immediately
	for i in items:
		print(i.source_options.get_selected_id())
		subtract_items(i.product_list[i.source_options.get_selected_id()], i.get_multiplier())
		i.update_quantity_text()
		

	# Lock the ability to change the recipe
	# Player can make more lemonade, but is restricted to this recipe only
	
	# Add the number from the spin box to the gallon variable
	gallons_of_lemonade += gallon_node.value
	
	# call the update again, disable the mix button if player doesn't have enough
	update_general()
	
	# Reset gallons back to 1
	gallon_node.value = 1
	


func subtract_items(item, multiplier) -> void :
	print("item subtracted")
	item.set_quantity(item.get_quantity() - multiplier)
	
func alert_player_cup_limit() -> void:
	# Check to see how many cups the player has
	# if they're trying to make too many gallons that the cups can't server
	# Warn the player that they will only be able to sell x amount of lemonade
	# the rest will be thrown out
	
	#SUM CUPS or limit one type of cup
	# Get player num cups
	var sum_cups = 0
	
	sum_cups = Global.cup_list[0].get_quantity()
	print(sum_cups)
	
	#GALLONS TO CUPS 16 cups to a gallon, a comparison
	var gallons_to_cups = (gallon_node.value + gallons_of_lemonade)* 16
	var enough_cups = sum_cups >= gallons_to_cups
	
	if enough_cups:
		# Hide the alert if it's visible
		exeeds_cup_label.visible = false
		
	else:
		# show the alert 
		exeeds_cup_label.add_color_override("font_color", Color(1, .5, .5))
		exeeds_cup_label.visible = true
