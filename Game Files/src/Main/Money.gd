extends Node

class Money:
	# Money object that holds the value of the player's wallet
	# emits a signal if the value gets changed
	# the MoneyLabel scene will update its string to the player
	# to the new current money value
	signal changed(value)
	var amount = 100.00 setget set_money, get_money
	
	# Called when the node enters the scene tree for the first time.
	func set_money(value) -> void:
		amount = value
		emit_signal("changed")
		
		
	func get_money() -> float:
		return amount
	

