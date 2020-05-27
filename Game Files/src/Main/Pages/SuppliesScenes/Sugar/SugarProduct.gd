extends "res://src/Main/Pages/SuppliesScenes/ProductBase/ProductClass.gd"


func _ready() -> void:
	product_list = Global.sugar_list
	populate_option_box()
	img_array = ["res://assets/images/sugar_granulated.jpg",
				"res://assets/images/sugar_cane.jpg",
				"res://assets/images/sugar_stevia.jpg"]
