extends "res://scenes/First Day/SuppliesScenes/IngredientSource.gd"

#var stuff = IngredientSource.new().IngredientItem.new()

func _ready() -> void:
	product_list = Global.lemon_list
	populate_option_box()

