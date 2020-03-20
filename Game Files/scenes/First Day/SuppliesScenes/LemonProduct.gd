extends "res://scenes/First Day/SuppliesScenes/IngredientSource.gd"

#var stuff = IngredientSource.new().IngredientItem.new()
onready var lemon_mix = IngredientItem.IngredientItem.new("lemon","lemonade mix", 1, 10)
onready var lemon_juice = IngredientItem.IngredientItem.new("lemon", "lemon juice concentrate", 2, 0)
onready var fresh_lemons = IngredientItem.IngredientItem.new("lemon", "fresh squeezed lemons", 4, 0)
onready var lemon_list = [lemon_mix, lemon_juice, fresh_lemons]


func _ready() -> void:
	product_list = lemon_list
	populate_option_box()

