extends VBoxContainer


func _ready():
	pass # Replace with function body.


func _on_Button_pressed():
	# Record the selection but for now, just make the screen go away.
	self.visible = false
	


func _on_RandomEventContainer_visibility_changed():
	# In the future, have a list of random events that occur
	# stuff them in array and pop one out at the end of the day
	pass # Replace with function body.
