extends Popup

"""
This contains the code for serving the lemonade!
May need to break into pieces later
"""
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var minigame := get_node(".")
onready var has_ice = false;
onready var has_sugar = false;

onready var debug_ice_text := get_node("HBoxContainer/CommandContainer/Debug/Ice")
onready var debug_sugar_text := get_node("HBoxContainer/CommandContainer/Debug/Sugar")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _process(delta: float) -> void:
	# draw the minigame screen
	# todo: only allow if there is an order or chore
	# in the queue and that queue item is selected
	# get the order in to here?
	if Input.is_action_pressed("ui_minigame") and not minigame.is_visible():
		popup()
	
	# take input commands from player
	# assign to actions
	# only check if the popup is visible
	if minigame.is_visible() == false:
		return
	else:
		if Input.is_action_pressed("ui_minigame_ice"):
			has_ice = true
		
		if Input.is_action_pressed("ui_minigame_sugar"):
			has_sugar = true
		
	if has_sugar:
		debug_sugar_text.add_color_override("font_color", Color(0, 255, 0))
	else:
		debug_sugar_text.add_color_override("font_color", Color(255, 255, 255))

	if has_ice:
		debug_ice_text.add_color_override("font_color", Color(0, 255, 0))
	else:
		debug_ice_text.add_color_override("font_color", Color(255, 255, 255))	
		
	# close minigame window
	if Input.is_action_pressed("ui_minigame_serve"):
		if minigame.is_visible():
			minigame.hide()
			has_sugar = false;
			has_ice = false;
			#send score on accuracy of filling order
			

