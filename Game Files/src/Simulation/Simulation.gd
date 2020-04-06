extends Control
signal pressed(value)
signal money_changed(value)
signal week_ends

"""
Run the numbers when player presses the start button.
Take in information from the player manipulated items.
Then display them on the end day screen
Display on the overview screen after Random Event is solved

Resides in OverviewContainer
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
onready var revenue
onready var lemonade_price = 1.00
onready var counter = 2

func calculate_customers() -> int:
	# calculate customers based on factors
	var base_num = 50
	var event = 25
	var weather = 10
	return base_num + event + weather
	
	
func run_sim() -> void:
	if counter > 1:
		var num_customers = calculate_customers()
		#revenue = num_customers * lemonade_price
		set_revenue(num_customers * lemonade_price)
		var cups = num_customers
		#print("You made $%s today" % get_revenue())
		
		#End of sim
		#Pop up of end of Day Overview
		#	How much money was made, customers served
		
		#pop up menu for random event
		print("Counter = %d"  % counter)
	else:
		# Run end of game
		# Display End game screen
		# Display total money made during the course of the game
		# Display total number of customers serviced
		# Display random event choices
		# What end does the player get? new display?
		emit_signal("week_ends")
		print("This is the end of the game!")
	
	
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func set_revenue(value) -> void:
	revenue = value
	emit_signal("money_changed", value)
	
func get_revenue() -> float:
	return revenue
	
func _on_StartGameButton_pressed() -> void:
	# Start game is in the Overview which this script should be attached to
	# Emits signal and revenue to Tabswitcher which will handle in its own function
	run_sim()
	counter -= 1
	emit_signal("pressed", get_revenue())


func _on_Price_changed(value) -> void:
	# Calls when the lemonade price has been changed in the lemonade scene
	# It shall update the lemonade price to the new current price.
	lemonade_price = value
