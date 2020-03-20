extends "res://scenes/First Day/SuppliesScenes/IngredientSource.gd"

onready var paper_cup = IngredientItem.IngredientItem.new("cup", "paper cups", 1, 0)
onready var plastic_cup = IngredientItem.IngredientItem.new("cup", "plastic cups", 2, 0)
onready var branded_cup = IngredientItem.IngredientItem.new("cup", "branded cups", 4, 0)
onready var cup_list = [paper_cup, plastic_cup, branded_cup]


func _ready() -> void:
	product_list = cup_list
	populate_option_box()
