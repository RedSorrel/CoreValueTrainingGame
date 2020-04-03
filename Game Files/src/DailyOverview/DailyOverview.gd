extends Control

signal pressed

onready var label = get_node("VBoxContainer/Label")
onready var revenue = 0.00
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Dismiss_pressed():
	# Hide the screen, 
	self.visible = false
	# Make Random Event scene visible
	# but do it outside of here since
	# Daily Overview cannot access RandomEvent Scene
	# Let the parent of the two handle that
	emit_signal("pressed")


func _on_DailyOverview_visibility_changed():
	# When Daily Overview has been made visible
	# Update the strings
	if self.visible:
		label.text = "You made $%.*f today" % [2, revenue]

func set_revenue_text(value) -> void:
	revenue = value
