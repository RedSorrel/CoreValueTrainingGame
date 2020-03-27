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
# Called when the node enters the scene tree for the first time.
func _ready():
	# connect the signal for when a ratio description has been changed by the player
	# when it is changed, update the string
	ratio_water.connect("change_recipe_desc", get_node("."), "update_lemonade_desc")
	ratio_lemon.connect("change_recipe_desc", get_node("."), "update_lemonade_desc")
	ratio_sugar.connect("change_recipe_desc", get_node("."), "update_lemonade_desc")
	
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
	alert_label.text = "You can make a max of 0 gallons of lemonade.\n To make this amount\n 0 water(s)\n 0 sugar(s)\n 0 lemon(s)\n will be used.\n"
