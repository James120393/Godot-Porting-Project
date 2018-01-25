extends Panel

# member variables here, example:

# var a=2
# var b="textvar"

func _ready():
	set_process_input(true)
	
func _input(event):
	if get_node("InfoBG/Cross").is_pressed():
		_on_cross_Button_pressed()
	if get_node("LevelSelectBG/Cross").is_pressed():
		_on_cross_Button_pressed()
	if get_node("Info").is_pressed():
		_on_info_Button_pressed()
	if get_node("Play").is_pressed():
		_on_play_Button_pressed()

func _on_info_Button_pressed():
	get_node("InfoBG").set_hidden(false)
	get_node("Play").set_disabled(true)

func _on_cross_Button_pressed():
	get_node("InfoBG").set_hidden(true)
	get_node("LevelSelectBG").set_hidden(true)
	get_node("Play").set_disabled(false)

func _on_play_Button_pressed():
	get_node("LevelSelectBG").set_hidden(false)
	
func load_Level(level_Number):
	var level = str("res://Scenes/Level_" + level_Number + ".tscn")
	get_tree().change_scene(level)

