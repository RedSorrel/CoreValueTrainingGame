extends "res://src/Main/Pages/LemonadeAndStandScene/LemonadeMixingMenu/IngredientSources/SourceBase/SourceItem.gd"


func _ready():
	.child_ready(Global.cup_list)
