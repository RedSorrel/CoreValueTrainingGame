extends Node

"""
Needs to contain information to be shared amongst many scenes.
Ingridient Items are something that needs to be shared between the
supply scene and the lemonade scene.

Add buffs to the products too, so we can display them


Probably need to save a 'recipe' as a string? to display on the overview page

Handle the buffs here to share across many scenes, get updated by those scenes.
"""
# Ingredient objects
var IngredientItem = preload("res://scenes/First Day/IngredientItem.gd")

onready var tap_water = IngredientItem.IngredientItem.new("water","tap water", 1, 10)
onready var bottled_water = IngredientItem.IngredientItem.new("water", "bottled water", 2, 0)
onready var spring_water = IngredientItem.IngredientItem.new("water", "spring water", 4, 0)

onready var water_list = [tap_water, bottled_water, spring_water]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func populate_option_box(product_list, option_box) -> void:
	for product in product_list:
		option_box.add_item(product.get_subtype().capitalize())
