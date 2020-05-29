extends Control

onready var random_event_summary = get_node("VBoxContainer/RandomEventSummary")
# Called when the node enters the scene tree for the first time.
func _ready():
	var summary_label = Label.new()
	var summary_text = "Hello"
	Global.player_stats["Choices"]["Day_1"] = ["You bbb", "Let's go'", "Because of this, that"]
	
	summary_text = "On day X, %s happened. You chose %s and because of that this happened: %s" % [Global.player_stats["Choices"]["Day_1"][0], Global.player_stats["Choices"]["Day_1"][0], Global.player_stats["Choices"]["Day_1"][0]]
	
	summary_label.text = summary_text
	# display the text
	random_event_summary.add_child(summary_label, true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_WeekEnds() -> void:
	# Day counter in Simulation.gd (Overview node) has dropped to 1
	# Time to present the end screen!
	self.visible = true
		
	
