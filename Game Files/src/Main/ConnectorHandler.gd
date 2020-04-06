extends MarginContainer

# Connect signals to their distant relatives
# This currently lives in TabsOnSide

func _ready():
	var money_label = get_node("Body/Header/ColorRect/HBoxContainer/MoneyLabel")
	var supplies_container = get_node("Body/Mid/Content/SuppliesContainer")
	var simulation_node = get_node("Body/Mid/Content/OverviewContainer")
	var end_screen = get_node("Body/Mid/Content/EndScreen")
	# Need to go through two levels of get_nodes in order to grab the container we want
	# Why? The info we need resides in LemonadeContainer, the signal we're looking for
	# Cannot assess through Lemonade AND Stand container, the parent container
	# So go down one more level and connect them
	var lemonade_container = get_node("Body/Mid/Content/LemonadeAndStandContainer").get_node("LemonadeInfo/LemonadeContainer")
	
	supplies_container.connect("money_changed", money_label, "_on_Money_changed")
	simulation_node.connect("money_changed", money_label, "_on_Money_changed")
	
	lemonade_container.connect("price_changed", simulation_node, "_on_Price_changed")
	
	simulation_node.connect("week_ends", end_screen, "_on_WeekEnds")
	pass
