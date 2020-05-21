extends Control

signal pressed
signal good_bad_points_changed

onready var prompt = get_node("MarginContainer/VBoxContainer/Prompt")
onready var good_choice = get_node("MarginContainer/VBoxContainer/GoodChoice")
onready var bad_choice = get_node("MarginContainer/VBoxContainer/BadChoice")
onready var dismiss = get_node("MarginContainer/VBoxContainer/Dismiss")
onready var reward_label = get_node("MarginContainer/VBoxContainer/RewardLabel")
onready var image:Node = get_node("MarginContainer/VBoxContainer/MarginContainer/NinePatchRect/Image")
# index 0 shall be good points
# index 1 shall be bad points
onready var good_bad_counter = [0,0]
"""
Template for prompts:
	0 Prompt text,
	1 Good Choice button text,
	2 Good choice reaction,
	3 Bad Choice button text, 
	4 Bad choice reaction
	5 Image
"""
onready var be_good_prompts = {
	0: [
		"You hand a customer a cup of lemonade. As you do, a bug flies into the cup. The customer hasn't noticed",
		"Pour a new cup",
		"The customer looks confused as you take back the cup. You exlain to the customer that there was a bug in the cup, as you pour them a fresh cup of lemonade. They smile and thank you for the new cup.",
		"Say nothing",
		"You smile at the customer and hand them the cup. You get paid all the same. Later you see that someone is ranting about your stand on a local area web forum.",
		"res://assets/images/random_event_fly_cup.jpg" ],
	1 : [
		"After purchasing some groceries you find that by mistake the clerk has given you too much money back in change.",
		"Return to the store and give the clerk back the extra change, explaining the mistake.",
		"You turn your cart around and wait for the clerk to finish checking out their queue. You explain what happened and hand the clerk the extra change. The clerk is grateful and thanks you for your honesty.",
		"Decide to keep the extra money to good use toward your lemonade stand.",
		"You put the money in your lemonade stand fund at home. On your next few trips to the grocery store, you notice that your regular clerk has been absent. Then you see a familiar face when serving lemonade. \n \"Yeah, they had to let me go because my register didn't balance out a week ago.\" they say as they sip on some lemonade.",
		"res://assets/images/random_event_change.jpg"],
	2 : [
		"During the day, a cyclist zips past your stand. You hear a thud and see that the cyclist’s wallet has fallen out of their pocket. You hold on to the wallet for safe keeping. Now it’s the end of the day and no one has come for it.",
		"Take the wallet to the police station, explaining where it was dropped.",
		"You decide to take the wallet to the police station. They help you write a report and the rest is up to them. The next day, the cyclist stops by and thanks you. They buy a cup of lemonade and tip you extra in thanks.",
		"Decide to mail the wallet, using the address found on the driver’s license, and take a few dollars as a reward.", 
		"You decide to pocket some money and then send the wallet. You notice that the cyclist rides on the other side of the road now. You can't really tell, but you feel like the cyclist is glaring at you from behind their sunglasses as they speed by.",
		"res://assets/images/random_event_wallet.jpg"],
	3 : [
		"During the day, a cyclist zips past your stand. You hear a thud and see that the cyclist’s wallet has fallen out of their pocket. You hold on to the wallet for safe keeping. Now it’s the end of the day and no one has come for it.",
		"Take the wallet to the police station, explaining where it was dropped.",
		"You decide to take the wallet to the police station. They help you write a report and the rest is up to them. The next day, the cyclist stops by and thanks you. They buy a cup of lemonade and tip you extra in thanks.",
		"Decide to mail the wallet, using the address found on the driver’s license, and take a few dollars as a reward.", 
		"You decide to pocket some money and then send the wallet. You notice that the cyclist rides on the other side of the road now. You can't really tell, but you feel like the cyclist is glaring at you from behind their sunglasses as they speed by.",
		"res://assets/images/random_event_wallet.jpg"]
}
	
onready var be_excellent_prompts = {
	0: [
		"Your local community leaders are trying to host a zombie walk! They’re taking donations to help get it ready and if they have enough - they’ll be able to get an actor from a popular TV series to come visit, putting your town on the map!",
		"Sounds like fun, donate now!",
		"You pitch in some money and take some fliers to display at your lemonade stand. You tell your customers about the event and help spread the word. The event gets its needed funds and then some and is a success!",
		"Donate later, you’ve some errands to run.",
		"You decide to donate later. You run your errands and get home, the memory of the event drifts out of your mind. The event date arrives and only a few vendors are there and few people participate in the walk.",
		"res://assets/images/random_event_placeholder.jpg"],
	1 : [
		"Research how to better yourself as an entrepreneur. While visiting the local library, you notice a flyer on a bulletin board. There is going to be a talk about how to better yourself as a salesperson.",
		"Let’s go!",
		"You attend the talk. You learn some new techniques to apply to your business and make friends with the other entrepreneurs there!",
		"Don’t go.",
		"You conduct business as usual, going through the motions.",
		"res://assets/images/random_event_placeholder.jpg"],
	2 : [
		"You awake to see rain streaming down your bedroom window. Your bed is nice and comfy and the outside looks miserable.",
		"Roll out of bed, you need to hustle!",
		"You set up shop and take shelter under your umbrella. Business is slow and eventually the rain lets up and sunlight begins to poke through the clouds. People begin pouring out of their homes to enjoy some time outside and some patronize your stand!",
		"Pull the covers over your head, you’ll try again tomorrow.",
		"Outcome: You stay in bed, resting. The rain lets up and you contemplate setting up your stand. You figure by the time you have it up and running it will be time to pack up and head home, so you stay inside for the rest of the evening.",
		"res://assets/images/random_event_placeholder.jpg"]
}

onready var be_friend_prompts = {
	0: [
		"An old acquaintance of yours comes to the lemonade stand to buy some of your lemonade. You are taken back by the memories of him being rude to you.",
		"Offer him the friend discount (15%) that you just offered to someone yesterday.",
		"This old friend loves the lemonade and turns out to be a local owner of a restaurant and wants to buy 1 gallon of lemonade every day",
		"Don’t forgive him for the bad memories and just offer the lemonade at normal price.",
		"You sold 1 cup of lemonade.",
		"res://assets/images/random_event_placeholder.jpg"],
	1 : [
		"Help a friend practice a presentation: A friend of yours is taking a class and has an assignment coming up where they must present to the class. They’re nervous and ask you if you would help them practice.",
		"Help them practice.",
		"You two set up in a conference room at the local library. They a first round of presenting and you take notes. At the end of the presentation you give constructive critique and they practice again. Each round they get more and more confident. A few days pass and your friend excitedly tells you that they received a high grade! They thank you for helping them practice!",
		"Don’t help them practice.",
		"A few days pass and your friend tells you that they felt that they didn’t do a good job and worries about their grade.",
		"res://assets/images/random_event_placeholder.jpg"],
	2 : [
		"Your younger cousin is struggling in a subject that you’re knowledgeable about.",
		"It’s a struggle. You try to teach them the way you know how to solve the problem but it’s not clicking. So you try different ways of explaining the problem, acting it out, drawing it, and others. Finally, their eyes widen with understanding and they scribble down the answer. You double check it and cheer because the answer is right.  After a few more tutoring sessions, your cousin’s grade begins to rise. You treat them to ice cream when they get an A on their test.",
		"Offer to do their homework for them.",
		"Your cousin’s grade raises! But they get in trouble for slacking off in class because they feel they don’t need to pay attention since you’re doing the work anyway. They struggle in future classes because they didn’t learn the basics.",
		"res://assets/images/random_event_placeholder.jpg"],
	3 : [
		"You get a call from Jo,  your friend. They want to hang out! However, you’ve already made plans with someone else.",
		"Raincheck, we can hang out another time.",
		"You tell Jo that you made plans today and ask when the next time they’re free.",
		"Agree to hang out.",
		"You call Joe and cancel your plans. You hang out at the park. You see Jo in the crowd of people and you hope she doesn’t see you.",
		"res://assets/images/random_event_placeholder.jpg"]
}

onready var be_you_prompts = {
	0: [
		"Some teenagers come by your stand and make fun of the fact that you are running a lemonade and not getting a “normal” job.",
		"You decide to forget ‘em and embrace your entrepreneurial spirit.",
		"Turns out it was a great day to sell lemonade, sales increase 10%!",
		"You’re embarrassed by the comments and decide to shut down for the day",
		"You didn't sell as much today",
		"res://assets/images/random_event_placeholder.jpg"],
	1 : [
		"After several days of hard work, you realize you are starting to slip on quality because the workload is becoming too much for one person. Hiring someone is a must.",
		"One applicant is above average, not as good as the other salesman and has room to grow. You also realize this person is aligned with your core values.",
		"Your sales steadily increase while you invest in this employee, eventually your sales double.",
		"One applicant is a solid salesperson. Guarantees that he will increase your sales by 50%, although, you are not entirely sure he follows your core values.",
		"Your sales do increase by 50%, but your customer service suffers and you start to lose customers.",
		"res://assets/images/random_event_placeholder.jpg"],
	2 : [
		"Something about being yourself",
		"Be Yourself",
		"You were totally yourself today!",
		"Be !You",
		"Bruh, you were not yourself today",
		"res://assets/images/random_event_placeholder.jpg"],
	3 : [
		"Something about being yourself",
		"Be Yourself",
		"You were totally yourself today!",
		"Be !You",
		"Bruh, you were not yourself today",
		"res://assets/images/random_event_placeholder.jpg"]
}

onready var today_prompts = []
# RNG
onready var rng = RandomNumberGenerator.new()
onready var rand 

func _ready():
	print("randoready")
	pass # Replace with function body.


func _on_RandomEventContainer_visibility_changed():
	# In the future, have a list of random events that occur
	# stuff them in array and pop one out at the end of the day
	# and pop it out of the array too, to keep from repeats
	rng.randomize()
	if today_prompts.size() > 0:
		rand = rng.randi() % today_prompts.size()
		display_prompt()
		
	# Hide the reward string each time the visibility changes
	# so when the it's the next day's event, it will not be visible
	reward_label.visible = false
	


func set_prompt(string) -> void:
	prompt.text = string

func display_prompt() -> void:
	# grab a random prompt and display it
	# start with one group and we'll add more later
	# Reset the visibility of the buttons
	if good_choice.visible == false:
		good_choice.visible = true
	
	if bad_choice.visible == false:
		bad_choice.visible = true
	
	if dismiss.visible == true:
		dismiss.visible = false
	
	prompt.text = today_prompts[rand][0]
	good_choice.set_text(today_prompts[rand][1])
	bad_choice.set_text(today_prompts[rand][3])
	image.set_texture(load(today_prompts[rand][5]))
	
	#print(be_good_prompts[rand])
	#set_prompt(be_good_prompts[rand][0])
	#button_one.set_text(be_good_prompts[rand][1])
	#button_two.set_text(be_good_prompts[rand][2])

func _on_set_Random_Event_type(value: String) -> void:
	if value == "good":
		# pick the good prompts
		today_prompts = be_good_prompts
	elif value == "excellent":
		# pick the be excellent prompts
		today_prompts = be_excellent_prompts
		pass
	elif value == "friend":
		today_prompts = be_friend_prompts
		pass
	elif value == "you":
		today_prompts = be_you_prompts
		pass
	else:
		print("Error: wrong value entered, please in put good, excellent, friend, or you")
	
	

func _on_GoodChoice_pressed():
	display_reaction(good_choice)
	good_bad_counter[0] += 1
	
	# This is just the easiest way of assigning awards to the player
	# Give the player money, instantly show that they got it in their wallet
	Global.money.set_money(Global.money.get_money() + 5.00)
	# Tell the player what they won in the labels, make it green for good
	reward_label.text = "You got $5.00"
	reward_label.add_color_override("font_color", Color(0, 255, 0))
	
func _on_BadChoice_pressed():
	display_reaction(bad_choice)
	good_bad_counter[1] += 1
	Global.money.set_money(Global.money.get_money() + 5.00)
	reward_label.text = "You got $5.00, but word got around and you lost some customers"
	reward_label.add_color_override("font_color", Color(1, .5, .5))

func display_reaction(button: Button) -> void:
	# Reuse this panel to display a reaction to the player
	# When will they learn that their actions have consquences?!
	# Needs to know what prompt we're on to display it
	
	#Clear the panel
	good_choice.visible = false
	bad_choice.visible = false
	dismiss.visible = true
	if button == good_choice:
		set_prompt(today_prompts[rand][2])
	else:
		set_prompt(today_prompts[rand][4])
		
	# Let's emit the signal for sending the points out to the simulation
	emit_signal("good_bad_points_changed", get_points())


func _on_Dismiss_pressed():
	self.visible = false
	# get rid of prompt, no duplicates!
	emit_signal("pressed")

func get_points() -> Array:
	return good_bad_counter
