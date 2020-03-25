extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var option_box = get_node("SourceOptions")
onready var product_list = Global.water_list
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.populate_option_box(product_list, option_box)


