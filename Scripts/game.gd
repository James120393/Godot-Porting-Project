extends Control

onready var tween = get_node("Tween")
onready var t_Coffee = get_node("Tween/Coffee")
onready var Player1 = get_node("Player1")
onready var Player2 = get_node("Player2")
onready var Coffee_Origin = get_node("Tween/Coffee").position

var Player1_CanPickUp = false
var Player2_CanPickUp = false
var Player1_CanPlace = false

var is_coffee = true

var state = {
	trans = Tween.TRANS_LINEAR,
	eases = Tween.EASE_IN,
}

enum Area_Player1{
	none,
	top_Left,
	top_Middle,
	top_Right
}
enum Area_Player2{
	none,
	bottom_Left,
	bottom_Middle,
	bottom_Right
}


func _ready():
	#set_process(true)
	pass

# Funtion to detect input events
func _input(event):
	var current_Level = get_tree().get_current_scene().get_name()
	var next = get_node("Next")
	var origin_Top = get_node("a").position
	
	if (Input.is_action_pressed("Player2_Pickup") and Player2_CanPickUp == true):
		_On_Pickup_Button_Pressed(Player2, Coffee_Origin)
	elif (Input.is_action_pressed("Player1_Pickup") and Player1_CanPickUp == true):
		_On_Pickup_Button_Pressed(Player1, origin_Top)
		get_node("a").subtract_Coffee()
	elif (Input.is_action_pressed("Player1_Drop") and Player1_CanPlace == true):
		_On_Drop_Button_Pressed()
	else:
		pass

# Read the values of the coffee and cake to see if the level should end
### TODO once the text reader is implemented change this to a function that reads the win conditions and compared it to the current condition
	if (current_Level == "0-0" and get_node("a").get_Coffee() == "Addy"):
		_end_Level()
	elif (current_Level == "0-1" and get_node("a").get_Coffee() == "Addy" and get_node("b").get_Coffee() == "Val"):
		_end_Level()
#	elif (current_Level == "0-2" and get_node("Coffee_Con_Left").get_Coffee() == "Val"):
#		_end_Level()
#	elif (current_Level == "0-3" and get_node("Coffee_Con_Left").get_Coffee() == "Val"):
#		_end_Level()
#	elif (current_Level == "1-0" and get_node("Coffee_Con_Left").get_Coffee() == "Val"):
#		_end_Level()
	
# Detect button presses
	if get_node("Play").is_pressed():
		_on_play_Button_pressed()
	if get_node("Reset").is_pressed():
		_on_reset_Button_pressed()
	if (next.is_pressed() and current_Level == "0-0"):
		_on_Next_Button_Pressed("0-1")
	elif (next.is_pressed() and current_Level == "0-1"):
		_on_Next_Button_Pressed("0-2")
	elif (next.is_pressed() and current_Level == "0-2"):
		_on_Next_Button_Pressed("0-3")
	elif (next.is_pressed() and current_Level == "0-3"):
		_on_Next_Button_Pressed("1-0")
	elif (next.is_pressed() and current_Level == "1-0"):
		_on_Next_Button_Pressed("1-1")

# Called every frame
func _process(delta):
	# set up local variables
	## TODO find a better way to declare locals
	var Player1_pos = get_node("Player1").position
	var Player2_pos = get_node("Player2").position
	var coffee_pos = get_node("Tween/Coffee").position

	# Check distance from the moving sprite to the player to detect
	# when the sprite should stop
	if (is_coffee == true):
		var Distance_Plr2_Coffee = coffee_pos.distance_to(Player2_pos)
		var Distance_Plr1_Coffee = coffee_pos.distance_to(Player1_pos)
		if (Distance_Plr2_Coffee <= 5):
			t_Coffee.set_visible(false)
			tween.stop_all()
			Player2.add_Coffee()
			tween.reset_all()
		elif (Distance_Plr1_Coffee <= 5):
			t_Coffee.set_visible(false)
			tween.stop_all()
			Player1.add_Coffee()
			tween.reset_all()
		else:
			pass

	elif (is_coffee == false):
		if (get_node("Tween/Cake") != null):
			var cake_pos = get_node("Tween/Cake").position
			var Distance_Plr2_Cake = cake_pos.distance_to(Player2_pos)
			var Distance_Plr1_Cake = cake_pos.distance_to(Player1_pos)
			if (Distance_Plr2_Cake <= 5):
				t_Coffee.set_visible(false)
				tween.stop_all()
				Player2.add_Cake()
				tween.reset_all()
			elif (Distance_Plr1_Cake <= 5):
				t_Coffee.set_visible(false)
				tween.stop_all()
				Player1.add_Cake()
				tween.reset_all()
				if (Area_Player1.top_Left == true):
					get_node("a").subtract_Coffee()
			else:
				pass
		else:
			pass
	else:
		pass

	# If player 1 has a value greater than 0 then they can place the value
	# if the value is = to 0 then they can not
	if (Player1.has_Value() == true):
		Player1_CanPlace = true
	else:
		Player1_CanPlace = false


# What to do when the drop button is pressed
func _On_Drop_Button_Pressed():
	var c_Con_Left = get_node("a")
	var c_Con_Middle = get_node("b")
	var c_Con_Rright = get_node("c")
	
	# see which area the player is currently in
	if (Player1.has_Value() == true):
		if (Area_Player1 == top_Left):
			c_Con_Left.add_Coffee("Addy")
			Player1.subtract_Coffee()
		elif (Area_Player1 == top_Middle):
			c_Con_Middle.add_Coffee("Addy")
			get_node("Player2_Value").update_Text("a", "a")
			Player1.subtract_Coffee()
		elif (Area_Player1 == top_Right):
			c_Con_Rright.add_Coffee("Addy")
			Player1.subtract_Coffee()
		else:
			pass
	elif (Player1.has_Value() == true ):
		if (Area_Player1 ==top_Left):
			c_Con_Left.add_Cake()
			Player1.subtract_Cake()
		elif (Area_Player1 == top_Middle):
			c_Con_Middle.add_Cake()
			Player1.subtract_Cake()
		elif (Area_Player1 == top_Right):
			c_Con_Rright.add_Cake()
			Player1.subtract_Cake()
		else:
			pass

##### TODO Make a better way to detect where the player is so this function can be smaller
# What to do whan the pickup button is pressed
func _On_Pickup_Button_Pressed(Player, origin):
	var origin_Top = get_node("a").position
	
	# depending on what player pressed the pickup button play an animation
	# Move the coffee to player 2
	if (Player2.has_Value() == false and Area_Player2 == bottom_Left or Player1.has_Value() == false and Area_Player1 == top_Left):
		is_coffee = true
		t_Coffee.set_visible(true)
		tween.follow_method(t_Coffee, "set_position", origin, Player, "get_position", 0.5, state.trans, state.eases)
		tween.targeting_method(t_Coffee, "set_position", Player, "get_position", origin, 0.5, state.trans, state.eases, 2)
		tween.start()
	# Check to see if the coffee is in this level
	elif (get_node("Tween/Cake") != null):
		var Cake_Origin = get_node("Tween/Cake").position
		var t_Cake = get_node("Tween/Cake")
		# Move the cake to plyer 2
		if (Area_Player2.bottom_Right == true or Area_Player1.top_Left == true):
			is_coffee = false
			t_Cake.set_visible(true)
			tween.follow_method(t_Cake, "set_position", Cake_Origin, Player, "get_position", 0.5, state.trans, state.eases)
			tween.targeting_method(t_Cake, "set_position", Player, "get_position", Cake_Origin, 0.5, state.trans, state.eases, 2)
			tween.start()


func _on_play_Button_pressed():
	get_node("Info").set_visible(false)
	get_node("Play").set_disabled(true)
	get_node("Play").set_visible(false)


# Reset the level
func _on_reset_Button_pressed():
	var levelname = get_tree().get_current_scene().get_name()
	var level = str("res://Scenes/Level_" + levelname + ".tscn")
	get_tree().change_scene(level)

func _on_Next_Button_Pressed(level_Number):
	get_node("Next").set_disabled(true)
	var level = str("res://Scenes/Level_" + level_Number + ".tscn")
	get_tree().change_scene(level)


func _end_Level():
	get_node("End").set_visible(true)
	get_node("Next").set_visible(true)
	get_node("Next").set_disabled(false)

#Function thats called when a player collides with the boxes 
### TODO fix issue with imputting too many arguments
func change_Value(name, name2):
	# This is the only container referenced as it is triggered by collision not input
	var container_a = get_node("a")
	var Player2_Value = Player2.get_Coffee()
	
	if (name2 == "Under_Left" and Player2_Value == "A"):
		Player2.subtract_Coffee()
		container_a.add_Coffee("Addy")
		get_node("Player2_Value").update_Text("a", "a")
		
	if (name2 == "Bottom_Left"):
		Area_Player2 = bottom_Left
		Player2_CanPickUp = true
	elif (name2 == "Bottom_Right"):
		Area_Player2 = bottom_Right
		Player2_CanPickUp = true
	elif (name2 == "Top_Left"):
		Area_Player1 = top_Left
		Player1_CanPickUp = true
	elif (name2 == "Top_Middle"):
		Area_Player1 = top_Middle
	elif (name2 == "Top_Right"):
		Area_Player1 = top_Right
	else:
		Area_Player1 = none
		Area_Player2 = none


func reset_Pickup(arg):
	Player2_CanPickUp = false
	Player1_CanPickUp = false

####TODO add function to attatch the AREA2d script to all areas and create/resize a collision shape to it.
