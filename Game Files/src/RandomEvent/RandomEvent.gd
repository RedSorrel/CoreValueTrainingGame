extends Control

signal pressed
signal good_bad_points_changed

onready var prompt = get_node("MarginContainer/VBoxContainer/Prompt")
onready var good_choice = get_node("MarginContainer/VBoxContainer/GoodChoice")
onready var bad_choice = get_node("MarginContainer/VBoxContainer/BadChoice")
onready var dismiss = get_node("MarginContainer/VBoxContainer/Dismiss")

# index 0 shall be good points
# index 1 shall be bad points
onready var good_bad_counter = [0,0]
"""
Template for prompts:
	Prompt text,
	Good Choice button text,
	Good choice reaction,
	Bad Choice button text, 
	Bad choice reaction
"""
onready var be_good_prompts = {
0: ["You hand a customer a cup of lemonade. As you do, a bug flies into the cup. The customer hasn't noticed",
 "Pour a new cup",
"The customer looks confused as you take back the cup. You exlain to the customer that there was a bug in the cup, as you pour them a fresh cup of lemonade. They smile and thank you for the new cup.",
"Say nothing",
"You smile at the customer and hand them the cup. You get paid all the same. Later you see that someone is ranting about your stand on a local area web forum."], 
1 : [
	"After purchasing some groceries you find that by mistake the clerk has given you too much money back in change.",
	"Return to the store and give the clerk back the extra change, explaining the mistake.",
	"You turn your cart around and wait for the clerk to finish checking out their queue. You explain what happened and hand the clerk the extra change. The clerk is grateful and thanks you for your honesty.",
	"Decide to keep the extra money to good use toward your lemonade stand.",
	"You put the money in your lemonade stand fund at home. On your next few trips to the grocery store, you notice that your regular clerk has been absent. Then you see a familiar face when serving lemonade. \n \"Yeah, they had to let me go because my register didn't balance out a week ago.\" they say as they sip on some lemonade."],
2 : [
	"During the day, a cyclist zips past your stand. You hear a thud and see that the cyclist’s wallet has fallen out of their pocket. You hold on to the wallet for safe keeping. Now it’s the end of the day and no one has come for it.",
	"Take the wallet to the police station, explaining where it was dropped.",
	"You decide to take the wallet to the police station. They help you write a report and the rest is up to them. The next day, the cyclist stops by and thanks you. They buy a cup of lemonade and tip you extra in thanks.",
	"Decide to mail the wallet, using the address found on the driver’s license, and take a few dollars as a reward.", 
	"You decide to pocket some money and then send the wallet. You notice that the cyclist rides on the other side of the road now. You can't really tell, but you feel like the cyclist is glaring at you from behind their sunglasses as they speed by."],
3 : [
	"During the day, a cyclist zips past your stand. You hear a thud and see that the cyclist’s wallet has fallen out of their pocket. You hold on to the wallet for safe keeping. Now it’s the end of the day and no one has come for it.",
	"Take the wallet to the police station, explaining where it was dropped.",
	"You decide to take the wallet to the police station. They help you write a report and the rest is up to them. The next day, the cyclist stops by and thanks you. They buy a cup of lemonade and tip you extra in thanks.",
	"Decide to mail the wallet, using the address found on the driver’s license, and take a few dollars as a reward.", 
	"You decide to pocket some money and then send the wallet. You notice that the cyclist rides on the other side of the road now. You can't really tell, but you feel like the cyclist is glaring at you from behind their sunglasses as they speed by."]
	}

# RNG
onready var rng = RandomNumberGenerator.new()
onready var rand 

func _ready():
	pass # Replace with function body.


func _on_RandomEventContainer_visibility_changed():
	# In the future, have a list of random events that occur
	# stuff them in array and pop one out at the end of the day
	# and pop it out of the array too, to keep from repeats
	rng.randomize()
	rand = rng.randi() % be_good_prompts.size()
	display_prompt()
	


func set_prompt(string) -> void:
	prompt.text = string

func display_prompt() -> void:
	# grab a random prompt and display it
	# start with one group and we'll add more later
	#Reset the visibility of the buttons
	if good_choice.visible == false:
		good_choice.visible = true
	
	if bad_choice.visible == false:
		bad_choice.visible = true
	
	if dismiss.visible == true:
		dismiss.visible = false
	
	prompt.text = be_good_prompts[rand][0]
	good_choice.set_text(be_good_prompts[rand][1])
	bad_choice.set_text(be_good_prompts[rand][3])
	
	#print(be_good_prompts[rand])
	#set_prompt(be_good_prompts[rand][0])
	#button_one.set_text(be_good_prompts[rand][1])
	#button_two.set_text(be_good_prompts[rand][2])


func _on_GoodChoice_pressed():
	display_reaction(good_choice)
	good_bad_counter[0] += 1
	
	
func _on_BadChoice_pressed():
	display_reaction(bad_choice)
	good_bad_counter[1] += 1


func display_reaction(button: Button) -> void:
	# Reuse this panel to display a reaction to the player
	# When will they learn that their actions have consquences?!
	# Needs to know what prompt we're on to display it
	
	#Clear the panel
	good_choice.visible = false
	bad_choice.visible = false
	dismiss.visible = true
	if button == good_choice:
		set_prompt(be_good_prompts[rand][2])
	else:
		set_prompt(be_good_prompts[rand][4])
		
	# Let's emit the signal for sending the points out to the simulation
	emit_signal("good_bad_points_changed", get_points())


func _on_Dismiss_pressed():
	self.visible = false
	# get rid of prompt, no duplicates!
	emit_signal("pressed")

func get_points() -> Array:
	return good_bad_counter
