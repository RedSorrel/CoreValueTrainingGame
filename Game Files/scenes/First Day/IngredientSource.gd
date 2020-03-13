extends HBoxContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var label = get_node("Label").text
onready var option_box = get_node("SourceOptions")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	populate_option_box()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func populate_option_box() -> void:
	if label == "Water Source":
		option_box.add_item("Tap Water")
		option_box.add_item("Bottled Water")
		option_box.add_item("Spring Water")
	elif label == "Sugar Source":
		option_box.add_item("Processed Sugar")
		option_box.add_item("Sugar Cane")
		option_box.add_item("Stevia")
	else:
		option_box.add_item("Lemonade Mix")
		option_box.add_item("Lemon Juice Concentrate")
		option_box.add_item("Fresh Squeezed Lemons")
