extends VBoxContainer

onready var prompt = get_node("ColorRect/Label2")
onready var button_one = get_node("ColorRect/Button")
onready var button_two = get_node("ColorRect/Button2")
onready var be_good_prompts = {0: ["Prompt", "Choice 1", "Choice 2"], 1 : ["a", "b", "c"], 2: ["Prompt 3", "Choice 1", "Choice 2"]}

func _ready():
	var new_prompt = "You hand a customer a cup of lemonade. As you do,  a bug flies into the cup. The customer has not noticed."
	button_one.set_text("Say Nothing.")
	button_two.set_text("Pour a new cup")
	set_prompt(new_prompt)
	display_prompt()
	pass # Replace with function body.


func _on_RandomEventContainer_visibility_changed():
	# In the future, have a list of random events that occur
	# stuff them in array and pop one out at the end of the day
	pass # Replace with function body.


func _on_Button_pressed():
	# Record the selection but for now, just make the screen go away.
	self.visible = false
	

func _on_Button2_pressed():
	pass # Replace with function body.

func set_prompt(string) -> void:
	prompt.text = string

func display_prompt() -> void:
	# grab a random prompt and display it
	var rng = RandomNumberGenerator.new()
	var rand = rng.randi_range(0,be_good_prompts.size()-1)
	print(rand)
	print(rand)
	print(rand)
	#print(be_good_prompts[rand])
	#set_prompt(be_good_prompts[rand][0])
	#button_one.set_text(be_good_prompts[rand][1])
	#button_two.set_text(be_good_prompts[rand][2])
