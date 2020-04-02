extends "res://src/Main/Pages/SuppliesScenes/ProductBase/ProductClass.gd"

#var stuff = IngredientSource.new().IngredientItem.new()

func _ready() -> void:
	product_list = Global.lemon_list
	populate_option_box()

