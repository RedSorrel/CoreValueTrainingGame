extends HBoxContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var buff_text := get_node("Buffs")
onready var ing_src_label := get_node("Label")
onready var ing_src_option := get_node("SourceOptions")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if ing_src_label.text == "Water Source":
		ing_src_option.add_item("Tap Water")
		ing_src_option.add_item("Bottled Water")
		ing_src_option.add_item("Spring Water")
	elif ing_src_label.text == "Sugar Source":
		ing_src_option.add_item("Processed Sugar")
		ing_src_option.add_item("Sugar Cane")
		ing_src_option.add_item("Stevia")
	else:
		ing_src_option.add_item("Lemonade Mix")
		ing_src_option.add_item("Lemon Juice Concentrate")
		ing_src_option.add_item("Lemons")
	

	buff_text.text = "0"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
