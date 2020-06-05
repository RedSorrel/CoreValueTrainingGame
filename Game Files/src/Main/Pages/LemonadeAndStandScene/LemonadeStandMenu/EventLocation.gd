extends HBoxContainer
# This is different from Random Events
# This is for events that take place during the simulation
# I.e. a football game going on in a stadium
# If the player sets up there, then they get more customers
# otherwise they don't get a bonus

# NOT IMPLEMENTED or at least not fully implemented

onready var locations = ["location 1", "location 2", "location 3"]
onready var location_dropdown = get_node("SettingsContainer/HBoxContainer/LocationDropdown")
onready var location_current = locations[0]
# Called when the node enters the scene tree for the first time.
func _ready():
	populate_dropdown(locations)
	pass # Replace with function body.

func populate_dropdown(array: Array) -> void:
	# Takes an array and fills the dropdown box with 
	# these array members as options
	for i in array:
		location_dropdown.add_item(i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LocationDropdown_item_selected(id):
	location_current = locations[id]
	print(location_current)
	
func _is_location_the_same(event_location: String) -> bool:
	if location_current == event_location:
		return true
	else:
		return false
