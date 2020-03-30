extends Node
signal selected

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
#onready var RatioDesc = get_node("RatioDescription")
#onready var RatioLabel = get_node("Label")
onready var water_ratio_desc = ["Water", "Watery", "Some Water", "Barely Any"]
onready var lemon_ratio_desc = ["Lemon", "Lemony", "Some Lemon", "Barely Any"]
onready var sugar_ratio_desc = ["Sugar", "Sugary", "Some Sugar", "Barely Any"]
onready var ratio_list = [water_ratio_desc, lemon_ratio_desc, sugar_ratio_desc]
onready var label_text = get_node("Label").text
onready var ratio_desc = get_node("RatioDescription")
onready var recipe_string
onready var ratio_multiplier setget set_ratio_multiplier, get_ratio_multiplier

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Fill the option boxes with their descriptions
	populate_ratio_boxes()
	
	#Set the recipe_string to the first description of everything at the start
	Global.recipe[label_text] = ratio_desc.get_item_text(0)
	# Get the id of the first item in the option button and pass it through
	# so that the multiplier displays correctly when the scene is loaded 
	set_ratio_multiplier(ratio_desc.get_selected_id())	

func populate_ratio_boxes() -> void:
	# This function will loop through an array of arrays
	# See if one of the arrays has text that is the same as the label text
	# Get rid of that text
	# then do another loop, this time filling the OptionBox "ratio_desc"
	# with the text inside the array.
	for ratio in ratio_list:
		if ratio.has(label_text):
			ratio.pop_front()
			for desc in ratio:
				ratio_desc.add_item(desc)

func _on_RatioDescription_item_selected(id):
	# When a different item is selected
	# update the recipe string
	Global.recipe[label_text] = ratio_desc.get_item_text(id)
	#call a func here to update the description string in lemonade view
	set_ratio_multiplier(id)
	emit_signal("selected")
	

func get_ratio_multiplier() -> int:
	# We'll use this value in the LemonadeContainer
	return ratio_multiplier
	
func set_ratio_multiplier(value) -> void:
	# Set the ratio multiplier so that
	# the first item in each option button consumes the most
	# to do that, we'll subtract the index of the selected item
	# from the max value of three
	# Watery multiplier = 3 vs barely any water = 1 
	ratio_multiplier = 3 - value
