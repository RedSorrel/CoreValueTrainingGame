extends Node

# Lives on the Mid node in Main
# used as a connection between all the scenes and buttons to switch between them

onready var overview_btn := get_node("TabButtonContainer/Overview") 
onready var overview_scene := get_node("Content/OverviewContainer")
onready var lemonade_btn := get_node("TabButtonContainer/Lemonade")
onready var lemonade_scene := get_node("Content/LemonadeAndStandContainer")
onready var supplies_btn := get_node("TabButtonContainer/Supplies")
onready var supplies_scene := get_node("Content/SuppliesContainer")

onready var daily_overview := get_node("Content/DailyOverview")
onready var random_event := get_node("Content/RandomEventContainer")

onready var active_scene = overview_scene
onready var active_button = overview_btn

onready var start_button := get_node("Content/OverviewContainer/StartGameButton")

func _ready() -> void:
	# Overview scene has the start game button that runs the simulation
	# Connect start button here because OverViewContainer doesn't know
	# Daily Overview exists, so use their parent instead.
	
	overview_scene.connect("pressed", self, "_on_StartGameButton_pressed")
	daily_overview.connect("pressed", self, "_on_Dismissed_pressed")
	make_active_visible()
	
	
#switch buttons on press, make old one inactive
func remove_active() -> void:
	active_button.pressed = false
	active_scene.visible = false
	
	
# make active scene visible
func make_active_visible() -> void:
	active_scene.visible = true
	
	
func set_active_scene(scene) -> void:
	active_scene = scene
	
func set_active_btn(button) -> void:
	active_button = button
	active_button.pressed = true

func change_active_menu(button, scene) -> void:
	remove_active()
	set_active_btn(button)
	set_active_scene(scene)
	make_active_visible()

func _on_Overview_pressed() -> void:
	if overview_btn.is_pressed():
		change_active_menu(overview_btn, overview_scene)
	else:
		overview_btn.pressed = true
		


func _on_Lemonade_pressed() -> void:
	if lemonade_btn.is_pressed():
		change_active_menu(lemonade_btn,lemonade_scene)
	else:
		lemonade_btn.pressed = true
	


func _on_Supplies_pressed() -> void:
	if supplies_btn.is_pressed():
		change_active_menu(supplies_btn,supplies_scene)
	else:
		supplies_btn.pressed = true

func _on_StartGameButton_pressed(revenue) -> void:
	#custom signal from simulation button press
	#Set the profit
	daily_overview.set_revenue_text(revenue)
	daily_overview.visible = true

func _on_Dismissed_pressed(isEnd) -> void:
	# Signal is emitted from the DailyOverview scene
	# happens when the dismiss button is pressed
	# Now we shall show the RandomEvent to the player
	if isEnd:
		pass
	else:
		random_event.visible = true
		print("TabSwitcher: Daily dissmissed has been pressed")
	
