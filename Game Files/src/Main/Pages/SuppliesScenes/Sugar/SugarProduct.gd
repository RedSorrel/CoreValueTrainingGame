extends "res://src/Main/Pages/SuppliesScenes/ProductBase/ProductClass.gd"


func _ready() -> void:
	product_list = Global.sugar_list
	populate_option_box()