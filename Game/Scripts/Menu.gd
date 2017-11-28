extends Panel

# member variables here, example:

# var a=2
# var b="textvar"

func _ready():
	set_process_input(true)
	
func _input(event):
	if get_node("InfoBG/Cross").is_pressed():
		_on_cross_Button_pressed()
	if get_node("Info").is_pressed():
		_on_info_Button_pressed()
	if get_node("Play").is_pressed():
		_on_play_Button_pressed()

func _on_info_Button_pressed():
    get_node("InfoBG").set_hidden(false)

func _on_cross_Button_pressed():
	get_node("InfoBG").set_hidden(true)

func _on_play_Button_pressed():
	get_tree().change_scene("res://Scenes/game.tscn")