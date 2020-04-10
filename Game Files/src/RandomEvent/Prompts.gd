extends Node

class Prompts:
	var prompt_text
	var good_choice_label
	var bad_choice_label
	var good_choice_reaction_text
	var bad_choice_reaction_text
	var reward = []
	
	func give_button_label(button: Button, type: String) -> void:
		if type == "good":
			button.set_text(good_choice_label)
		else:
			button.set_text(bad_choice_label)
			
	func get_prompt_text() -> String:
		return prompt_text
	
	
	func get_reaction() -> String:
		if true:
			return good_choice_reaction_text
		else:
			return bad_choice_reaction_text
			
	func get_reward() -> String:
		var temp_string = "You get "
		
		for i in reward:
			temp_string += i + " "
			
		
		return temp_string
