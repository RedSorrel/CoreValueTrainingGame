extends Node

onready var label_template = "Money: $%.*f"

func _ready():
		self.text = label_template % [2, Global.money.get_money()]
		Global.money.connect("changed", get_node("."), "_on_Money_changed" )
		pass # Replace with function body.

func _on_Money_changed() -> void:
	# When money is changed, update the wallet string
	var amount = Global.money.get_money()
	self.text = label_template % [2, amount]
	pass
