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
onready var ratios = [ratio_water, ratio_lemon, ratio_sugar]

onready var item_water = get_node("SettingsContainer/LemonadeIngredients/IngredientSource/SourceWater")
onready var item_lemon = get_node("SettingsContainer/LemonadeIngredients/IngredientSource/SourceLemon")
onready var item_sugar = get_node("SettingsContainer/LemonadeIngredients/IngredientSource/SourceSugar")
onready var items = [item_water, item_lemon, item_sugar]

onready var gallon_node = get_node("SettingsContainer/LemonadeIngredients/HBoxContainer/Gallons")

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
	# called when ratio option boxes ore gallon spin box have been changed
	# to display relevant text such as the recipe change,
	# how much lemonade the player can make
	# and updating multipliers
	update_lemonade_desc()
	update_alert_label()
	set_multipliers(gallon_node.value)
	print(item_water.get_multiplier())
	
func update_alert_label() -> void:
	alert_label.text = "You can make a max of 0 gallons of lemonade.\n To make this amount\n" + str(ratio_water.get_ratio_multiplier()) + " water(s) \n" + str(ratio_lemon.get_ratio_multiplier())+ " lemon(s)\n" + str(ratio_sugar.get_ratio_multiplier()) + " sugar(s)\n will be used."


func set_multipliers(gallons) -> void:
	# update the multipliers in case anything has changed
	for i in range(0, ratios.size()):
		items[i].set_multiplier(ratios[i].get_ratio_multiplier() * gallons)


func _on_Gallons_value_changed(value):
	# For each item type, loop through and call option toggle
	# in order to check and disable / renable items in the drop down box
	for i in items:
		i.call_option_toggle()
	update_general()
	print("Gallon value = " + str(value))
	print("multiplier water = " + str(item_water.get_multiplier()))
	pass # Replace with function body.
