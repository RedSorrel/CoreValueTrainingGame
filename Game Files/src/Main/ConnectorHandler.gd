extends MarginContainer

# Connect signals to their distant relatives
# This currently lives in TabsOnSide

func _ready():
	var money_label = get_node("Body/Header/ColorRect/HBoxContainer/MoneyLabel")
	var supplies_container = get_node("Body/Mid/Content/SuppliesContainer")
	var simulation_node = get_node("Body/Mid/Content/StartGameContainer")
	var random_event = get_node("Body/Mid/Content/RandomEventContainer")

	# Need to go through two levels of get_nodes in order to grab the container we want
	# Why? The info we need resides in LemonadeContainer, the signal we're looking for
	# Cannot assess through Lemonade AND Stand container, the parent container
	# So go down one more level and connect them
	var lemonade_container = get_node("Body/Mid/Content/LemonadeAndStandContainer").get_node("LemonadeInfo/LemonadeContainer")
	var lemonade_stand = get_node("Body/Mid/Content/LemonadeAndStandContainer").get_node("StandInfoContainer")
	
	
	supplies_container.connect("money_changed", money_label, "_on_Money_changed")
	
	# When money is added or subtracted, display it on the hud (the label in the top right of the screen)
	simulation_node.connect("money_changed", money_label, "_on_Money_changed")
	
	# When the player updates the price, let simulation node know
	# so it can calculate how much money the player makes that day
	lemonade_container.connect("price_changed", simulation_node, "_on_Price_changed")
	
	# When the player makes a choice, keep track of good and bad points
	# Add customers if there are a lot of good choices
	# and remove customers if there are a lot of bad choices
	# this affects how much money the player makes, currently
	random_event.connect("good_bad_points_changed", simulation_node, "_on_Good_Bad_Points_changed")
	
	# Tell the RandomEvent node what random event type (Good, Excellent, Friend, You)
	# to display that day
	simulation_node.connect("random_event_set", random_event, "_on_set_Random_Event_type")
	
	# Grants a bonus number of customers if the player picks a location that is the same as a location picked by 
	# the game or by the designer
	simulation_node.connect("get_location", lemonade_stand, "_is_location_the_same")
	
	# When the simulation runs, reset the gallons displayed in the lemonade stand scene (where it shows total gallons made for that day)
	simulation_node.connect("simulation_resets_gallons", lemonade_container, "_on_Simulation_resets_gallons")
	
	#When the simulation runs, use up the cups and update the "currently have" string in the store
	simulation_node.connect("simulation_uses_cups", supplies_container, "_on_Cups_used")
	pass
