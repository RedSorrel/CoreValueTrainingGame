extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_WeekEnds() -> void:
	# Day counter in Simulation.gd (Overview node) has dropped to 1
	# Time to present the end screen!
	self.visible = true
