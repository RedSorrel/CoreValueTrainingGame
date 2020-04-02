extends Control
"""
Run the numbers when player presses the start button.
Take in information from the player manipulated items.
Then display them on the end day screen
Display on the overview screen after Random Event is solved
"""
#onready var money_label = get_node("TabsOnSide/Main/Header/ColorRect/HBoxContainer/MoneyLabel")

# TODO:
# get cups in stock number
# get volume of lemonade number
# Decide on depletion rate of lemonade
# Create a day node that handles weather and events
# get lemonade price from player inputs
# send player adjusted values into the system, save in variables
# develop point system, very simple system to calc # customers
# set up signal emitter binders in parent node
# send calculated values back into the system
#		display in overview, update money in money bar
func calculate_customers() -> int:
	# calculate customers based on factors
	var base_num = 50
	var event = 25
	var weather = 10
	return base_num + event + weather
	
	
func run_sim() -> void:
	var num_customers = calculate_customers()
	var lemonade_price = 1.50
	
	var revenue = num_customers * lemonade_price
	var cups = num_customers
	print(revenue)
	
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_StartGameButton_pressed() -> void:
	run_sim()
