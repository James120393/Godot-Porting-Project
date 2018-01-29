extends Control

onready var tween = get_node("Tween")
onready var t_Coffee = get_node("Tween/Coffee")
onready var Player1 = get_node("Player1")
onready var Player2 = get_node("Player2")
onready var Coffee_Origin = get_node("Tween/Coffee").get_pos()

var Player1_CanPickUp = false
var Player2_CanPickUp = false
var Player1_CanPlace = false

var is_coffee = true

var state = {
	trans = Tween.TRANS_LINEAR,
	eases = Tween.EASE_IN,
}

var Area_Player1 = {
	none = true,
	top_Left = false,
	top_Middle = false,
	top_Right = false
}
var Area_Player2 = {
	none = true,
	bottom_Left = false,
	bottom_Middle = false,
	bottom_Right = false
}


func _ready():
	#set_process(true)
	set_process_input(true)
	set_process(true)

# Funtion to detect input events
func _input(event):
	var current_Level = get_tree().get_current_scene().get_name()
	var next = get_node("Next")
	var origin_Top = get_node("Coffee_Con_Left").get_pos()
	
	if (Input.is_action_pressed("Player2_Pickup") and Player2_CanPickUp == true):
		_On_Pickup_Button_Pressed(Player2, Coffee_Origin)
	elif (Input.is_action_pressed("Player1_Pickup") and Player1_CanPickUp == true):
		_On_Pickup_Button_Pressed(Player1, origin_Top)
		get_node("Coffee_Con_Left").subtract_Coffee()
	elif (Input.is_action_pressed("Player1_Drop") and Player1_CanPlace == true):
		_On_Drop_Button_Pressed()
	else:
		pass

# Read the values of the coffee and cake to see if the level should end
### TODO once the text reader is implemented change this to a function that reads the win conditions and compared it to the current condition
	if (current_Level == "0-0" and get_node("Coffee_Con_Left").get_Coffee() == "Val"):
		_end_Level()
	elif (current_Level == "0-1" and get_node("Coffee_Con_Left").get_Coffee() == "Val" and get_node("Coffee_Con_Middle").get_Coffee() == "Addy"):
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
	var Player1_pos = get_node("Player1").get_pos() 
	var Player2_pos = get_node("Player2").get_pos()
	var coffee_pos = get_node("Tween/Coffee").get_pos()

	# Check distance from the moving sprite to the player to detect
	# when the sprite should stop
	if (is_coffee == true):
		var Distance_Plr2_Coffee = coffee_pos.distance_to(Player2_pos)
		var Distance_Plr1_Coffee = coffee_pos.distance_to(Player1_pos)
		if (Distance_Plr2_Coffee <= 5):
			t_Coffee.set_hidden(true)
			tween.stop_all()
			Player2.add_Coffee()
			tween.reset_all()
		elif (Distance_Plr1_Coffee <= 5):
			t_Coffee.set_hidden(true)
			tween.stop_all()
			Player1.add_Coffee()
			tween.reset_all()
		else:
			pass

	elif (is_coffee == false):
		if (get_node("Tween/Cake") != null):
			var cake_pos = get_node("Tween/Cake").get_pos()
			var Distance_Plr2_Cake = cake_pos.distance_to(Player2_pos)
			var Distance_Plr1_Cake = cake_pos.distance_to(Player1_pos)
			if (Distance_Plr2_Cake <= 5):
				t_Coffee.set_hidden(true)
				tween.stop_all()
				Player2.add_Cake()
				tween.reset_all()
			elif (Distance_Plr1_Cake <= 5):
				t_Coffee.set_hidden(true)
				tween.stop_all()
				Player1.add_Cake()
				tween.reset_all()
				if (Area_Player1.top_Left == true):
					get_node("Coffee_Con_Left").subtract_Coffee()
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
	var c_Con_Left = get_node("Coffee_Con_Left")
	var c_Con_Middle = get_node("Coffee_Con_Middle")
	var c_Con_Rright = get_node("Coffee_Con_Right")
	
	# see which area the player is currently in
	if (Player1.has_Value() == true):
		if (Area_Player1.top_Left == true):
			c_Con_Left.add_Coffee("Addy")
			Player1.subtract_Coffee()
		elif (Area_Player1.top_Middle == true):
			c_Con_Middle.add_Coffee("Addy")
			get_node("Player2_Value").update_Text("a", "Coffee_Con_Middle")
			Player1.subtract_Coffee()
		elif (Area_Player1.top_Right == true):
			c_Con_Rright.add_Coffee("Addy")
			Player1.subtract_Coffee()
		else:
			pass
	elif (Player1.has_Value() == true ):
		if (Area_Player1.top_Left == true):
			c_Con_Left.add_Cake()
			Player1.subtract_Cake()
		elif (Area_Player1.top_Middle == true):
			c_Con_Middle.add_Cake()
			Player1.subtract_Cake()
		elif (Area_Player1.top_Right == true):
			c_Con_Rright.add_Cake()
			Player1.subtract_Cake()
		else:
			pass

##### TODO Make a better way to detect where the player is so this function can be smaller
# What to do whan the pickup button is pressed
func _On_Pickup_Button_Pressed(Player, origin):
	var origin_Top = get_node("Coffee_Con_Left").get_pos()
	
	# depending on what player pressed the pickup button play an animation
	# Move the coffee to player 2
	if (Player2.has_Value() == false and Area_Player2.bottom_Left == true or Player1.has_Value() == false and Area_Player1.top_Left == true):
		is_coffee = true
		t_Coffee.set_hidden(false)
		tween.follow_method(t_Coffee, "set_pos", origin, Player, "get_pos", 0.5, state.trans, state.eases)
		tween.targeting_method(t_Coffee, "set_pos", Player, "get_pos", origin, 0.5, state.trans, state.eases, 2)
		tween.start()
	# Check to see if the coffee is in this level
	elif (get_node("Tween/Cake") != null):
		var Cake_Origin = get_node("Tween/Cake").get_pos()
		var t_Cake = get_node("Tween/Cake")
		# Move the cake to plyer 2
		if (Area_Player2.bottom_Right == true or Area_Player1.top_Left == true):
			is_coffee = false
			t_Cake.set_hidden(false)
			tween.follow_method(t_Cake, "set_pos", Cake_Origin, Player, "get_pos", 0.5, state.trans, state.eases)
			tween.targeting_method(t_Cake, "set_pos", Player, "get_pos", Cake_Origin, 0.5, state.trans, state.eases, 2)
			tween.start()
	# Move the coffee to player 1
#	elif (Player == "Player1"):
#		is_coffee = true
#		t_Coffee.set_hidden(false)
#		tween.follow_method(t_Coffee, "set_pos", origin_Top, Player1, "get_pos", 0.5, state.trans, state.eases)
#		tween.targeting_method(t_Coffee, "set_pos", Player1, "get_pos", origin_Top, 0.5, state.trans, state.eases, 2)
#		tween.start()
#	# Check to see if the cake is in this level
#	elif (Player == "Player1" and get_node("Tween/Cake") != null):
#		var Cake_Origin = get_node("Tween/Cake").get_pos()
#		var t_Cake = get_node("Tween/Cake")
#		# Move the cake to player 1
#		if (get_node("Tween/Cake") != null):
#			is_coffee = true
#			t_Cake.set_hidden(false)
#			tween.follow_method(t_Cake, "set_pos", origin_Top, Player1, "get_pos", 0.5, state.trans, state.eases)
#			tween.targeting_method(t_Cake, "set_pos", Player1, "get_pos", origin_Top, 0.5, state.trans, state.eases, 2)
#			tween.start()


func _on_play_Button_pressed():
	get_node("Info").set_hidden(true)
	get_node("Play").set_disabled(true)
	get_node("Play").set_hidden(true)


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
	get_node("End").set_hidden(false)
	get_node("Next").set_hidden(false)
	get_node("Next").set_disabled(false)

#Function thats called when a player collides with the boxes 
### TODO fix issue with imputting too many arguments
func change_Value(name, name2, name3, name4, name5):
	# This is the only container referenced as it is triggered by collision not input
	var c_Con_Left = get_node("Coffee_Con_Left")
	var Player2_Value = Player2.get_Coffee()
	
	if (name5 == "Under_Left" and Player2_Value == "A"):
		Player2.subtract_Coffee()
		c_Con_Left.add_Coffee("Val")
		get_node("Player2_Value").update_Text("a", "Coffee_Con_Left")
		
	if (name5 == "Bottom_Left"):
		Area_Player2.bottom_Left = true
		Area_Player2.bottom_Right = false
		Player2_CanPickUp = true
	elif (name5 == "Bottom_Right"):
		Area_Player2.bottom_Left = false
		Area_Player2.bottom_Right = true
		Player2_CanPickUp = true
	elif (name5 == "Top_Left"):
		Area_Player1.top_Left = true
		Area_Player1.top_Right = false
		Area_Player1.top_Middle = false
		Player1_CanPickUp = true
	elif (name5 == "Top_Middle"):
		Area_Player1.top_Left = false
		Area_Player1.top_Right = false
		Area_Player1.top_Middle = true
	elif (name5 == "Top_Right"):
		Area_Player1.top_Left = false
		Area_Player1.top_Right = true
		Area_Player1.top_Middle = false


func reset_Pickup(arg, arg2, arg3, arg4):
	Player2_CanPickUp = false
	Player1_CanPickUp = false

####TODO add function to attack the AREA2d script to all areas and create/resize a collision shape to it.

####TODO complete funtion to add new coffee and make that coffee a child of the tween node
func new_Coffee():
	pass
#	var Player2_pos = get_node("Player2").get_pos()
#	# Declare Variables by calling the new() function
#	var spawn_Coffee = Node2D.new()
#	var coffee_Sprite  = Sprite.new()
#	
#	# Set the two node to be a child of the scene
#	get_node("Coffee_Dis").add_child(spawn_Coffee)
#	spawn_Coffee.add_child(coffee_Sprite)
#	
#	# Set the owner of the new nodes
#	spawn_Coffee.set_owner(get_node("Coffee_Dis"))
#	coffee_Sprite.set_owner(spawn_Coffee)
#	
#	# Load the texture and set the scale/Position
#	coffee_Sprite.set_texture(load("res://Art/Cup.png"))
#	spawn_Coffee.set_scale(Vector2(0.5,0.5))
#	spawn_Coffee.set_pos(Player2_pos)


