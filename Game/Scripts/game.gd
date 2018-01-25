extends Control

onready var tween = get_node("Tween")
onready var t_Coffee = get_node("Tween/Coffee")
onready var t_Cake = get_node("Tween/Cake")
onready var Player1 = get_node("Player1")
onready var Player2 = get_node("Player2")
onready var Coffee_Origin = get_node("Tween/Coffee").get_pos()
onready var Cake_Origin = get_node("Tween/Cake").get_pos()

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

	if (Input.is_action_pressed("Player2_Pickup") and Player2_CanPickUp == true):# and _check_area() == "Player2"):
		_On_Pickup_Button_Pressed("Player2")
	elif (Input.is_action_pressed("Player1_Pickup") and Player1_CanPickUp == true):
		_On_Pickup_Button_Pressed("Player1")
		get_node("Coffee_Con_Left").subtract_Coffee()
	elif (Input.is_action_pressed("Player1_Drop") and Player1_CanPlace == true):
		_On_Drop_Button_Pressed()
	else:
		pass

# Detect button presses
	if get_node("Play").is_pressed():
		_on_play_Button_pressed()
	if get_node("Reset").is_pressed():
		_on_reset_Button_pressed()

# Called every frame
func _process(delta):
	# set up local variables
	## TODO find a better way to declare locals
	var Player1_pos = get_node("Player1").get_pos() 
	var Player2_pos = get_node("Player2").get_pos()
	var coffee_pos = get_node("Tween/Coffee").get_pos()
	var cake_pos = get_node("Tween/Cake").get_pos()

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
		else:
			pass
	else:
		pass

	# If player 1 has a value greater than 0 then they can place the value
	# if the value is = to 0 then they can not
	if (Player1.get_Coffee() >= 1):
		Player1_CanPlace = true
	else:
		Player1_CanPlace = false


# What to do when the drop button is pressed
func _On_Drop_Button_Pressed():
	var c_Con_Left = get_node("Coffee_Con_Left")
	var c_Con_Middle = get_node("Coffee_Con_Middle")
	var c_Con_Rright = get_node("Coffee_Con_Right")
	
	# see which area the player is currently in
	if (Player1.get_Coffee() >= 1 and c_Con_Left.is_full() == false):
		if (Area_Player1.top_Left == true):
			c_Con_Left.add_Coffee()
			Player1.subtract_Coffee()
		elif (Area_Player1.top_Middle == true):
			c_Con_Middle.add_Coffee()
			Player1.subtract_Coffee()
		elif (Area_Player1.top_Right == true):
			c_Con_Rright.add_Coffee()
			Player1.subtract_Coffee()
		else:
			pass
	elif (Player1.get_Cake() >= 1 and c_Con_Left.is_full() == false):
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
func _On_Pickup_Button_Pressed(Player):
	var origin_Top = get_node("Coffee_Con_Left").get_pos()
	
	# depending on what player pressed the pickup button play an animation
	if (Player == "Player2" and Area_Player2.bottom_Left == true):
		is_coffee = true
		t_Coffee.set_hidden(false)
		tween.follow_method(t_Coffee, "set_pos", Coffee_Origin, Player2, "get_pos", 2, state.trans, state.eases)
		tween.targeting_method(t_Coffee, "set_pos", Player2, "get_pos", Coffee_Origin, 2, state.trans, state.eases, 2)
		tween.start()
	elif (Player == "Player2" and Area_Player2.bottom_Right == true):
		is_coffee = false
		t_Cake.set_hidden(false)
		tween.follow_method(t_Cake, "set_pos", Cake_Origin, Player2, "get_pos", 2, state.trans, state.eases)
		tween.targeting_method(t_Cake, "set_pos", Player2, "get_pos", Cake_Origin, 2, state.trans, state.eases, 2)
		tween.start()
	elif (Player == "Player1"):
		is_coffee = true
		t_Coffee.set_hidden(false)
		tween.follow_method(t_Coffee, "set_pos", origin_Top, Player1, "get_pos", 2, state.trans, state.eases)
		tween.targeting_method(t_Coffee, "set_pos", Player1, "get_pos", origin_Top, 2, state.trans, state.eases, 2)
		tween.start()


func _on_play_Button_pressed():
	get_node("Info").set_hidden(true)
	get_node("Play").set_disabled(true)
	get_node("Play").set_hidden(true)


# Reset the level
func _on_reset_Button_pressed():
	var levelname = get_tree().get_current_scene().get_name()
	var level = str("res://Scenes/" + levelname + ".tscn")
	get_tree().change_scene(level)

#Function thats called when a player collides with the boxes 
### TODO fix issue with imputting too many arguments
func change_Value(name, name2, name3, name4, name5):
	var Player1 = get_node("Player1")
	var Player2 = get_node("Player2")
	# This is the only container referenced as it is triggered by collision not input
	var c_Con_Left = get_node("Coffee_Con_Left")
	var Player2_Value = Player2.get_Coffee()
	
	if (name5 == "Under_Left" and Player2_Value >= 1):
		Player2.subtract_Coffee()
		c_Con_Left.add_Coffee()
		
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


