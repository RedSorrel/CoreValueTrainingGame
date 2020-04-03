extends Node

signal changed

onready var money = 100.00 setget set_money, get_money
onready var label_template = "Money: $%.*f"
# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = label_template % [2, get_money()]
	pass # Replace with function body.


func set_money(value) -> void:
	Global.money = value
	
func get_money() -> float:
	return Global.money
	
func _on_Money_changed(value) -> void:
	set_money(Global.money + value)
	self.text = label_template % [2, Global.money]
	print("Money is now %f " % Global.money)
