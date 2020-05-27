extends "res://src/Main/Pages/SuppliesScenes/ProductBase/ProductClass.gd"


func _ready() -> void:
	product_list = Global.cup_list
	populate_option_box()
	img_array = ["res://assets/images/cup_plastic.jpg"]
