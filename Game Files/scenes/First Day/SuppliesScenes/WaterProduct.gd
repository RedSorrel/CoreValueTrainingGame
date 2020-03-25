extends "res://scenes/First Day/SuppliesScenes/IngredientSource.gd"

#onready var tap_water = IngredientItem.IngredientItem.new("water","tap water", 1, 10)
#onready var bottled_water = IngredientItem.IngredientItem.new("water", "bottled water", 2, 0)
#onready var spring_water = IngredientItem.IngredientItem.new("water", "spring water", 4, 0)

func _ready() -> void:
	product_list = Global.water_list
	populate_option_box()
	
