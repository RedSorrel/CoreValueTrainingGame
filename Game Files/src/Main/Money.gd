extends Node

signal changed


class Money:
	var amount = 100.00 setget set_money, get_money
	
	# Called when the node enters the scene tree for the first time.
	func set_money(value) -> void:
		amount = value
		emit_signal("changed")
		
		
	func get_money() -> float:
		print("Money in wallet" + str(amount))
		return amount
	
onready var label_template = "Money: $%.*f"


func _ready():
		self.text = label_template % [2, Global.money2.get_money()]
		Global.money2.connect("changed", get_node("."), "_on_Money_changed" )
		pass # Replace with function body.

func _on_Money_changed() -> void:
	var amount = Global.money2.get_money()
	self.text = label_template % [2, amount]
	print("Money is now %f " % amount)
	pass
	

