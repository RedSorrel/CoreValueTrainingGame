extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var lemonade_tab_button := get_node("TabsOnSide/Main/Mid/TabButtonContainer/Lemonade")
onready var overview_tab_button := get_node("TabContainer/Overview")

onready var lemonade_info := get_node("TabsOnSide/Main/Mid/Content/LemonadeInformationContainer")
onready var overview_container := get_node("TabsOnSide/Main/Mid/Content/OverviewContainer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Lemonade_pressed() -> void:
	if lemonade_tab_button.is_pressed():
		overview_container.visible = false
		lemonade_info.visible = true
		#lemonade_tab_button.disabled = true
	else:
		lemonade_tab_button.pressed = true
	
