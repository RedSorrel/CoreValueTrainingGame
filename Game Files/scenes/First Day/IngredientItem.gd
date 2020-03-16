
extends Node

class IngredientItem:
	var _type setget , get_type
	var _subtype setget , get_subtype
	var _quantity setget set_quantity, get_quantity
	var _price setget set_price, get_price
	
	func _init(type, subtype, price, quantity) -> void:
		self._type = type
		self._subtype = subtype
		self._quantity = quantity
		self._price = price
	
		
	func set_quantity(quantity) -> void:
		_quantity = quantity
		
	func set_price(price) -> void:
		_price = price

	func get_type() -> String:
		return _type
		
	func get_subtype() -> String:
		return _subtype
		
	func get_quantity() -> int:
		return _quantity
		
	func get_price() -> int:
		return _price
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var myIng = IngredientItem.new("water", "tap water", 2, 10)
	print (myIng.get_type())
	myIng.set_quantity(20)
	print(myIng.get_quantity()) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
