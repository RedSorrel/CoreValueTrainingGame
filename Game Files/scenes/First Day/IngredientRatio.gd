extends VBoxContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var RatioDesc = get_node("RatioDescription")
onready var RatioLabel = get_node("Label")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if RatioLabel.text == "Water":
		RatioDesc.add_item("Watery")
		RatioDesc.add_item("Some Water")
		RatioDesc.add_item("Barely Any")
		
	elif RatioLabel.text == "Sugar":
		RatioDesc.add_item("Sugary")
		RatioDesc.add_item("Some Sugar")
		RatioDesc.add_item("Barely Any")
	else:
		RatioDesc.add_item("Lemony")
		RatioDesc.add_item("Some Lemon")
		RatioDesc.add_item("Barely Any")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
