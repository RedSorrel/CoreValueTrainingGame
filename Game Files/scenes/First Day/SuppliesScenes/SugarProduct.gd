extends "res://scenes/First Day/SuppliesScenes/IngredientSource.gd"


func _ready() -> void:
	product_list = Global.sugar_list
	populate_option_box()
