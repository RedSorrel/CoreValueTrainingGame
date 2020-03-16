
extends Node

class IngredientItem:
	var _type = "" setget , get_type
	var _subtype = "" setget , get_subtype
	var _quantity = 0 setget set_quantity, get_quantity
	
	func _init(type, subtype, quantity) -> void:
		self._type = type
		self._subtype = subtype
		self._quantity = quantity
		
	func set_quantity(quantity) -> void:
		_quantity = quantity

	func get_type() -> String:
		return _type
		
	func get_subtype() -> String:
		return _subtype
		
	func get_quantity() -> int:
		return _quantity
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var myIng = IngredientItem.new("water", "tap water", 10)
	print (myIng.get_type())
	myIng.set_quantity(20)
	print(myIng.get_quantity()) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
