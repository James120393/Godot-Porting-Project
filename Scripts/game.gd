extends Control

onready var tween = get_node("Tween")
onready var t_Coffee = get_node("Tween/Tween_Coffee")
onready var Player1 = get_node("Player1")
onready var Player2 = get_node("Player2")
onready var Coffee_Origin = get_node("Tween/Tween_Coffee").position
onready var current_Level = get_tree().get_current_scene().get_name()
onready var Player1_State = Player1.player1_Has_Pointer_Tool()

var Player1_CanPickUp = false
var Player2_CanPickUp = false
var Player1_CanPlace = false

var t_Cake = null
var cake_Origin = null
var player2_Previous_Value = null

var is_coffee = true
var check_Move = false

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
	bottom_Right
}

func _ready():
	#set_process(true)
	#Adding to group fro map creation to allow atting a script to any number of containers.
	var trees = self.get_children()
	var names = []
	var containers = ["a", "b", "c", "q"]
	var group = []
	for i in trees:
		names.append(i.get_name())
	for n in names:
		if n in containers:
			group.append(get_node(n))
	for g in group:
		g.add_to_group("Container")
	for k in group:
		print(k.get_name())
	pass

# Funtion to detect input events
func _input(event):
	var current_Level = get_tree().get_current_scene().get_name()
	var next = get_node("Next")
	var origin_Top = get_node("a").position
	
	if (Input.is_action_pressed("Player2_Pickup") and Player2_CanPickUp == true):
		_On_Pickup_Button_Pressed(Player2, Coffee_Origin)
		check_Move = true
	elif (Input.is_action_pressed("Player1_Pickup") and Player1_CanPickUp == true):
		_On_Pickup_Button_Pressed(Player1, origin_Top)
		check_Move = true
	elif (Input.is_action_pressed("Player1_Drop") and Player1_CanPlace == true):
		_On_Drop_Button_Pressed()
	else:
		pass

# Read the values of the coffee and cake to see if the level should end
### TODO once the text reader is implemented change this to a function that reads the win conditions and compared it to the current condition
	if (current_Level == "0-0" and get_node("a").get_True_Value() == "A"):
		_end_Level()
	elif (current_Level == "0-1" and get_node("a").get_True_Value() == "A" and get_node("b").get_True_Value() == "A"):
		_end_Level()
	elif (current_Level == "0-2" and get_node("a").get_True_Value() == "A" and get_node("b").get_True_Value() == "A" and get_node("c").get_True_Value() == "A"):
		_end_Level()
	elif (current_Level == "0-3" and get_node("a").get_True_Value() == "A" and get_node("b").get_True_Value() == "B"):
		_end_Level()
	elif (current_Level == "1-0" and get_node("*q").get_Value() == "Val"):
		_end_Level()

# Detect button presses
	if get_node("Play").is_pressed():
		_on_play_Button_pressed()
	if get_node("Quit").is_pressed():
		_on_quit_Button_pressed()
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
		_on_Next_Button_Pressed("Menu")

# Called every frame
func _process(delta):
	# set up local variables
	## TODO find a better way to declare locals
	var Player1_pos = get_node("Player1").position
	var Player2_pos = get_node("Player2").position
	var coffee_pos = get_node("Tween/Tween_Coffee").position

	# Check distance from the moving sprite to the player to detect
	# when the sprite should stop
	if (is_coffee == true and check_Move == true):
		var Distance_Plr2_Coffee = coffee_pos.distance_to(Player2_pos)
		var Distance_Plr1_Coffee = coffee_pos.distance_to(Player1_pos)
		if (Distance_Plr2_Coffee <= 5):
			t_Coffee.set_visible(false)
			tween.stop_all()
			Player2.add_Value("Coffee")
			tween.reset_all()
			check_Move = false
		elif (Distance_Plr1_Coffee <= 5):
			t_Coffee.set_visible(false)
			tween.stop_all()
			# The argument here is for the add_Value function to know what to call its self
			# e.g. if Area_Player1 == Top-Left then the coffee will be named "a" after the name of the container the player is standing above
			Player1.add_Value(Area_Player1, "Coffee")
			tween.reset_all()
			coffee_pos = Coffee_Origin
			check_Move = false
		else:
			pass

	elif (is_coffee == false and check_Move == true):
		if (get_node("Tween/Tween_Cake") != null):
			var cake_pos = get_node("Tween/Tween_Cake").position
			var Distance_Plr2_Cake = cake_pos.distance_to(Player2_pos)
			var Distance_Plr1_Cake = cake_pos.distance_to(Player1_pos)
			if (Distance_Plr2_Cake <= 5):
				t_Cake.set_visible(false)
				tween.stop_all()
				Player2.add_Value("Cake")
				tween.reset_all()
				check_Move = false
			elif (Distance_Plr1_Cake <= 5):
				t_Cake.set_visible(false)
				tween.stop_all()
				Player1.add_Value(Area_Player1, "Cake")
				tween.reset_all()
				cake_pos = cake_Origin
				check_Move = false
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
	if (Player1_State == false):
		if (Player1.get_Value() != null):
			if (Area_Player1 == top_Left):
				pass
			elif (Area_Player1 == top_Middle):
				#add the value to the container
				c_Con_Middle.add_Value("Addy", Player1.get_Value())
			elif (Area_Player1 == top_Right):
				c_Con_Rright.add_Value("Addy", Player1.get_Value())
			else:
				pass
		else:
			pass
	else:
		if (Area_Player1 == top_Left):
			Player1.set_Attached(false, "a")
			c_Con_Left.attach_Pointer()
		elif (Area_Player1 == top_Middle):
			#add the value to the container
			c_Con_Middle.add_Value("Addy", Player1.get_Value())
		elif (Area_Player1 == top_Right):
			c_Con_Rright.add_Value("Addy", Player1.get_Value())
		else:
			pass


##### TODO Make a better way to detect where the player is so this function can be smaller
# What to do whan the pickup button is pressed
func _On_Pickup_Button_Pressed(Player, origin):
	var origin_Top = get_node("a").position
	
	# depending on what player pressed the pickup button play an animation
	# Check to see which player is picking up the coffe as well as checking the previouse value of player 2 to allow the desicion
	# between the cake or coffee
	if (Player == Player2 and Area_Player2 == bottom_Left):
		_animation(Player, origin, "Coffee")
	elif (Player == Player1 and Area_Player1 == top_Left and player2_Previous_Value == "A" and get_node("a").has_Value() == true):
		_animation(Player, origin, "Coffee")
	# Check to see if the cake is in this level
	elif (get_node("Tween/Tween_Cake") != null):
		#Check for which player is picking up the cake
		if (Player == Player2 and Area_Player2 == bottom_Right):
			_animation(Player, origin, "Cake")
		elif (Player == Player1 and Area_Player1 == top_Left and player2_Previous_Value == "B" and get_node("a").has_Value() == true):
			_animation(Player, origin, "Cake")
	


func _animation(Player, origin, item):
	if (item == "Coffee"):
		is_coffee = true
		t_Coffee.set_visible(true)
		tween.follow_method(t_Coffee, "set_position", origin, Player, "get_position", 0.5, state.trans, state.eases)
		tween.targeting_method(t_Coffee, "set_position", Player, "get_position", origin, 0.5, state.trans, state.eases, 2)
		tween.start()
	else:
		#set the original postition for th cake to make it return to the bottom of the screen when player 1 picks it up
		cake_Origin = get_node("Tween/Tween_Cake").position

		#Create a local varable to use in the animation and check which player is picking it up to decide which area the cake will begin it animation.
		var cake_Origin_Local = null
		if (Player == Player2):
			cake_Origin_Local = get_node("Tween/Tween_Cake").position
		else:
			cake_Origin_Local = origin

		t_Cake = get_node("Tween/Tween_Cake")
		is_coffee = false
		# Move the cake to plyer 2
		t_Cake.set_visible(true)
		tween.follow_method(t_Cake, "set_position", cake_Origin_Local, Player, "get_position", 0.5, state.trans, state.eases)
		tween.targeting_method(t_Cake, "set_position", Player, "get_position", cake_Origin_Local, 0.5, state.trans, state.eases, 2)
		tween.start()


func _on_play_Button_pressed():
	get_node("Info").set_visible(false)
	get_node("Play").set_disabled(true)
	get_node("Play").set_visible(false)

func _on_quit_Button_pressed():
	get_tree().change_scene("res://Scenes/Level_menu.tscn")

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
func change_Value(args, name):
	# This is the only container referenced as it is triggered by collision not input
	var container_a = get_node("a")
	
	if (name == "Under_Left" and Player2.get_Value() == "A"):
		player2_Previous_Value = "A"
		container_a.add_Value("Val", "Coffee")
		container_a.move_sprite()
		#get_node("Player2_Value").update_Text("a", "a")
	elif (name == "Under_Left" and Player2.get_Value() == "B"):
		player2_Previous_Value = "B"
		container_a.add_Value("Val", "Cake")
		container_a.move_sprite()

	if (name == "Bottom_Left"):
		Area_Player2 = bottom_Left
		Player2_CanPickUp = true
	elif (name == "Bottom_Right"):
		Area_Player2 = bottom_Right
		Player2_CanPickUp = true
	elif (name == "Top_Left"):
		Area_Player1 = top_Left
		Player1_CanPickUp = true
	elif (name == "Top_Middle"):
		Area_Player1 = top_Middle
	elif (name == "Top_Right"):
		Area_Player1 = top_Right
	else:
		Area_Player1 = none
		Area_Player2 = none


func reset_Pickup(arg):
	Player2_CanPickUp = false
	Player1_CanPickUp = false

####TODO add function to attatch the AREA2d script to all areas and create/resize a collision shape to it.
