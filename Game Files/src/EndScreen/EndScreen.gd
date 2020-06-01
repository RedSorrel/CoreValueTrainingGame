extends Control

onready var random_event_summary: GridContainer = get_node("VBoxContainer/RandomEventSummary")
onready var summary_label : Label = get_node("VBoxContainer/RandomEventSummary/SummaryLabel")
onready var player_stat_label : RichTextLabel = get_node("VBoxContainer/PlayerStatsLabel")
# Called when the node enters the scene tree for the first time.
func _ready():
	#var summary_label = Label.new()
	#var summary_text = "Hello"
	#Global.player_stats["Choices"]["Day_1"] = ["You bbb", "Let's go'", "Because of this, that"]
	#for i in Global.player_stats["Choices"].size():
		#print(Global.player_stats["Choices"]["Day_%s" % str(i+1) ])
	#summary_text = "On day X, %s happened. You chose %s and because of that this happened: %s" % [Global.player_stats["Choices"]["Day_1"][0], Global.player_stats["Choices"]["Day_1"][0], Global.player_stats["Choices"]["Day_1"][0]]
	
	#summary_label.text = summary_text
	# display the text
	#random_event_summary.add_child(summary_label, true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_WeekEnds() -> void:
	# Day counter in Simulation.gd (Overview node) has dropped to 1
	# Time to present the end screen!
	self.visible = true
	

func summarize() -> void:
	var player_stat_text = ""
	var summary_text = ""
	# RANDOM EVENT SUMMARY
	
	for i in Global.player_stats["Choices"].size()-1:
		#print(Global.player_stats["Choices"]["Day_%s" % str(i+1) ])
		summary_text += "On day %s, %s happened. \n You chose %s and because of that this happened:\n %s\n\n" % [str(i+1), Global.player_stats["Choices"]["Day_" + str(i+1)][0], Global.player_stats["Choices"]["Day_" + str(i + 1)][1], Global.player_stats["Choices"]["Day_" + str(i + 1)][2]]
	# Set label text to the summary text
	summary_label.text = summary_text
	
	player_stat_text = "[b]Total Money Earned:[/b] %s [b]Total Customers Served:[/b] %s [b]Total Gallons Made:[/b] %s" % [str(Global.player_stats["Money"]), str(Global.player_stats["Customers"]), str(Global.player_stats["Gallons"])]
	player_stat_label.set_bbcode(player_stat_text)
	
	

func _on_EndScene_visibility_changed():
	# Display the summary text when the end screen becomes visible
	summarize()
