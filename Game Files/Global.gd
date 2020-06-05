extends Node

signal changed
"""
Needs to contain information to be shared amongst many scenes.
Ingredient Items are something that needs to be shared between the
supply scene and the lemonade scene.
"""
# Ingredient objects
var IngredientItem = preload("res://src/Main/Pages/SuppliesScenes/IngredientItemClass.gd")
var Money = preload("res://src/Main/Money.gd")
# Ingredient Item: type, name, cost, starting quantity 
# 					"water", "tap water", "2", 10
# limiting everything to 1 item for now, until buffs are added
# otherwise no sense having more items and expensive ones without any benefit
# or make everything cost the same
onready var tap_water = IngredientItem.IngredientItem.new("water","tap water", 1, 10)
onready var bottled_water = IngredientItem.IngredientItem.new("water", "bottled water", 1, 0)
onready var spring_water = IngredientItem.IngredientItem.new("water", "spring water", 1, 0)
onready var water_list = [tap_water, bottled_water, spring_water]

onready var paper_cup = IngredientItem.IngredientItem.new("cup", "paper cups", 1, 0)
onready var plastic_cup = IngredientItem.IngredientItem.new("cup", "plastic cups", 1, 16)
onready var branded_cup = IngredientItem.IngredientItem.new("cup", "branded cups", 1, 0)
onready var cup_list = [plastic_cup]

onready var lemon_mix = IngredientItem.IngredientItem.new("lemon","lemonade mix", 1, 10)
onready var lemon_juice = IngredientItem.IngredientItem.new("lemon", "lemon juice concentrate", 1, 0)
onready var fresh_lemons = IngredientItem.IngredientItem.new("lemon", "fresh squeezed lemons", 1, 0)
onready var lemon_list = [lemon_mix, lemon_juice, fresh_lemons]

onready var process_sugar = IngredientItem.IngredientItem.new("sugar", "processed sugar", 1, 10)
onready var cane_sugar = IngredientItem.IngredientItem.new("sugar", "cane sugar", 1, 0)
onready var stevia = IngredientItem.IngredientItem.new("sugar", "stevia", 1, 0)
onready var sugar_list = [process_sugar, cane_sugar, stevia]

# Record player stats here in a dictionary
# Will be accessed in other scripts where each stat
# will be added to and displayed on the end screen
onready var player_stats = {
	"Money" : 0,
	"Gallons": 0,
	"Customers": 0,
	"Choices": {}
}

###########
## Money ##
###########
onready var money = Money.Money.new()
# recipe string, used to show the player the recipe they used the day before
# as well as to display a lemonade description in IngredientRatio.gd
onready var recipe = {}

func populate_option_box(product_list: Array, option_box:Node) -> void:
	for product in product_list:
		option_box.add_item(product.get_subtype().capitalize())

func cost_string(product_list: Array) -> String:
	return "Cost $%s / unit" % product_list[0].get_price()

