extends "res://scenes/First Day/SuppliesScenes/IngredientSource.gd"

onready var tap_water = IngredientItem.IngredientItem.new("water","tap water", 1, 10)
onready var bottled_water = IngredientItem.IngredientItem.new("water", "bottled water", 2, 0)
onready var spring_water = IngredientItem.IngredientItem.new("water", "spring water", 4, 0)

onready var water_list = [tap_water, spring_water, bottled_water]


func _ready() -> void:
	product_list = water_list
	populate_option_box()
