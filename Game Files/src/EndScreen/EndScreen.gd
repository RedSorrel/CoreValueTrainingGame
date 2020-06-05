extends Control

onready var random_event_summary: GridContainer = get_node("VBoxContainer/RandomEventSummary")
onready var summary_label : Label = get_node("VBoxContainer/RandomEventSummary/SummaryLabel")
onready var player_stat_label : RichTextLabel = get_node("VBoxContainer/PlayerStatsLabel")


func _on_WeekEnds() -> void:
	# Day counter in Simulation.gd (Overview node) has dropped to 1
	# Time to present the end screen!
	self.visible = true
	

func summarize() -> void:
	var player_stat_text = ""
	var summary_text = ""
	# RANDOM EVENT SUMMARY
	
	for i in Global.player_stats["Choices"].size()-1:
		summary_text += "On day %s, %s happened. \n You chose %s and because of that this happened:\n %s\n\n" % [str(i+1), Global.player_stats["Choices"]["Day_" + str(i+1)][0], Global.player_stats["Choices"]["Day_" + str(i + 1)][1], Global.player_stats["Choices"]["Day_" + str(i + 1)][2]]
	# Set label text to the summary text
	# Get's rid of punctuation for some reason
	summary_label.text = summary_text
	
	# Display player stats, Money earned, customers served, etc
	player_stat_text = "[b]Total Money Earned:[/b] %s [b]Total Customers Served:[/b] %s [b]Total Gallons Made:[/b] %s" % [str(Global.player_stats["Money"]), str(Global.player_stats["Customers"]), str(Global.player_stats["Gallons"])]
	player_stat_label.set_bbcode(player_stat_text)
	
	

func _on_EndScene_visibility_changed():
	# Display the summary text when the end screen becomes visible
	summarize()
