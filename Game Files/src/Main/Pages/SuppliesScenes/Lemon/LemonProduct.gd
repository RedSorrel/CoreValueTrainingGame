extends "res://src/Main/Pages/SuppliesScenes/ProductBase/ProductClass.gd"

#var stuff = IngredientSource.new().IngredientItem.new()

func _ready() -> void:
	product_list = Global.lemon_list
	populate_option_box()
	img_array = ["res://assets/images/lemon_drink_mix.jpg",
				"res://assets/images/lemon_lemon_juice.jpg",
				"res://assets/images/lemon_lemons.jpg"
				]
