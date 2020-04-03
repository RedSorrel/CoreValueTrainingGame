extends MarginContainer

# Connect signals to their distant relatives
# This currently lives in TabsOnSide

func _ready():
	var money_label = get_node("Body/Header/ColorRect/HBoxContainer/MoneyLabel")
	var supplies_container = get_node("Body/Mid/Content/SuppliesContainer")
	var simulation_node = get_node("Body/Mid/Content/OverviewContainer")
	
	supplies_container.connect("money_changed", money_label, "_on_Money_changed")
	simulation_node.connect("money_changed", money_label, "_on_Money_changed")
	pass
