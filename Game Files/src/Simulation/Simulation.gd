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
onready var counter = 10

onready var todays_recipe = []
onready var good_bad_points = [0,0]
# Update this later, pull from another function/node/variable
# 	so when that is updated, this is updated too DRY
onready var recipe_water = ["watery", "some water", "barely any"]
onready var recipe_sugar = ["sugary", "some sugar", "barely any"]
onready var recipe_lemon = ["lemony", "some lemon", "barely any"]
onready var recipe_descriptors = [recipe_water, recipe_lemon, recipe_sugar]


func get_bonus_recipe_rand() -> void:
	# Randomly generate a recipe
	# Get bonus customers if you have it
	print(Global.recipe)
	var rng = RandomNumberGenerator.new()
		
	for i in recipe_descriptors.size():
		rng.randomize()
		var rand = rng.randi() % recipe_water.size()
		todays_recipe.append(recipe_descriptors[i][rand]) 
		
func set_bonus_recipe(water, lemon, sugar) -> void:
	# lowercase
	todays_recipe = [water, lemon, sugar]

func is_player_recipe_same() -> bool:
	# compare the two recipes
	# if they're the same, true
	# if they're not, false
	#copy dictionary into an array
	var player_recipe = [
		Global.recipe["Water"].to_lower(),
		Global.recipe["Lemon"].to_lower(),
		Global.recipe["Sugar"].to_lower()]
		
	return player_recipe == todays_recipe
	
func calculate_customers() -> int:
	# calculate customers based on factors
	# Base numbers
	var base_num = 50
	var event = 25
	var weather = 10
	
	# Bonus customers if the recipe is the same as today's bonus recipe
	if is_player_recipe_same():
		base_num += 20
		
	# Get the choices the player has made and pointify them
	# + 1 for good, - 1 for bad
	# multiply by 10? and get that many customers
	base_num += (10 * good_bad_points[0]) - (10 * good_bad_points[1])
	
	# Add a few based on
	return base_num + event + weather
	

func run_sim() -> void:
	get_bonus_recipe_rand()
	if counter > 1:
		var num_customers = calculate_customers()
		#revenue = num_customers * lemonade_price
		set_revenue(num_customers * lemonade_price)
		var cups = num_customers
		
		
		# Add revenue to the wallet!
		Global.money.set_money(Global.money.get_money() + get_revenue())
	
	
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
	#emit_signal("money_changed", value)
	emit_signal("money_changed")
	
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

func _on_Good_Bad_Points_changed(points_array) -> void:
	# Random event has ran, we need to save the current points
	# so we can give or loose customers based on player's choices
	good_bad_points = points_array
	print("Something got picked in the random event!")
	print("Ponts go something like this good: %d bad: %d" % [good_bad_points[0], good_bad_points[1]])
	
