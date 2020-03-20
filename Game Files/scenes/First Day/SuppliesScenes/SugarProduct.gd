extends "res://scenes/First Day/SuppliesScenes/IngredientSource.gd"

onready var process_sugar = IngredientItem.IngredientItem.new("sugar", "processed sugar", 1, 10)
onready var cane_sugar = IngredientItem.IngredientItem.new("sugar", "cane sugar", 2, 0)
onready var stevia = IngredientItem.IngredientItem.new("sugar", "stevia", 4, 0)
onready var sugar_list = [process_sugar, cane_sugar, stevia]


func _ready() -> void:
	product_list = sugar_list
	populate_option_box()
