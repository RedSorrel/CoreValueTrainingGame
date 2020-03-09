extends HBoxContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var label = get_node("Label")
onready var option_box = get_node("SourceOptions")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	option_box.add_item("Tap Water")
	option_box.add_item("Bottled Water")
	option_box.add_item("Spring Water")
	
	option_box.add_item("Processed Sugar")
	option_box.add_item("Sugar Cane")
	option_box.add_item("Stevia")
	
	option_box.add_item("Lemonade Mix")
	option_box.add_item("Lemon Juice Concentrate")
	option_box.add_item("Fresh Squeezed Lemons")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
