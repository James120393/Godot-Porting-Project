extends RigidBody2D

export var Player_speed = 200

var coffee = str()
var cake = str()

var Move_Right = Input.is_action_pressed("Player1_Move_Right")
var Move_Left = Input.is_action_pressed("Player1_Move_Left")

enum player1_State{
	none,
	has_CoffeeOrCake,
	has_Pointer_Tool
}

func _ready():
	# Initalization here
	set_Player_State()
	pass

	
func _process(delta):
	Move_Right = Input.is_action_pressed("Player1_Move_Right")
	Move_Left = Input.is_action_pressed("Player1_Move_Left")
	var line_Position = Vector2 (self.get_position().x, self.get_position().y)
	
	
	if Move_Right:
		set_linear_velocity(Vector2(Player_speed,get_linear_velocity().y))
		var line = get_node("../Line2D")
		if (line != null):
			line.set_point_position (2, line_Position)
			line.draw()
	elif Move_Left:
		set_linear_velocity(Vector2(-Player_speed,get_linear_velocity().y))
	else:
		set_linear_velocity(Vector2(0,get_linear_velocity().y))


func change_Player_Sprite():
	var Player1 = get_node("Player1_Sprite")
	
	if (player1_State == has_CoffeeOrCake):
		if (get_Coffee() != ""):
			Player1.set_texture(load("res://Art/Player1_Sprite_Plate_Coffee.png"))
		elif (get_Cake() != ""):
			Player1.set_texture(load("res://Art/Player1_Sprite_Plate_Cake.png"))
		else:
			Player1.set_texture(load("res://Art/Player1_Sprite.png"))
	elif (player1_State == has_Pointer_Tool):
			Player1.set_texture(load("res://Art/Player1_Sprite_Pointer.png"))

func get_Player_POS():
	return get_node("../Player1").position

#Add coffee
func add_Coffee(name):
	if (player1_State == has_CoffeeOrCake):
		if (typeof(name) == TYPE_INT):
			if (name == 1):
				coffee = "a"
				get_node("../Player1_Value").update_Text("Addy", "Coffee", "Player1")
				change_Player_Sprite()
			elif (name == 2):
				coffee = "b"
				get_node("../Player1_Value").update_Text("Addy", "Coffee", "Player1")
				change_Player_Sprite()
			elif (name == 3):
				coffee = "c"
				get_node("../Player1_Value").update_Text("Addy", "Coffee", "Player1")
				change_Player_Sprite()
			else:
				pass
		else:
			pass
		if (typeof(name) == TYPE_STRING):
			coffee = name
			get_node("../Player1_Value").update_Text("Addy", "Coffee", "Player1")
			change_Player_Sprite()
		else:
			pass
	else:
		pass
	

#Subtract coffee
func subtract_Coffee():
	coffee = ""
	change_Player_Sprite()

func get_Coffee():
	return coffee

#Add cake
func add_Cake(name):
	if (player1_State == has_CoffeeOrCake):
		if (typeof(name) == TYPE_INT):
			if (name == 1):
				cake = "a"
				get_node("../Player1_Value").update_Text("Addy", "Cake", "Player1")
				change_Player_Sprite()
			elif (name == 2):
				cake = "b"
				get_node("../Player1_Value").update_Text("Addy", "Cake", "Player1")
				change_Player_Sprite()
			elif (name == 3):
				cake = "c"
				get_node("../Player1_Value").update_Text("Addy", "Cake", "Player1")
				change_Player_Sprite()
			else:
				pass
		else:
			pass
		if (typeof(name) == TYPE_STRING):
			cake = name
			get_node("../Player1_Value").update_Text("Addy", "Cake", "Player1")
			change_Player_Sprite()
		else:
			pass#
	else:
		pass

#Subtract cake
func subtract_Cake():
	cake = ""
	change_Player_Sprite()

func get_Cake():
	return cake

func has_Value():
	if (coffee != "" or cake != ""):
		return true
	else:
		return false

func set_Player_State():
	var current_Level = get_tree().get_current_scene().get_name()
	if (current_Level == "0-0"):
		player1_State = has_CoffeeOrCake
	elif (current_Level == "0-1"):
		player1_State = has_CoffeeOrCake
	elif (current_Level == "0-2"):
		player1_State = has_CoffeeOrCake
	elif (current_Level == "0-3"):
		player1_State = has_CoffeeOrCake
	elif (current_Level == "1-0"):
		player1_State = has_Pointer_Tool
		change_Player_Sprite()