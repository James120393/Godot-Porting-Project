extends RigidBody2D

export var Player_speed = 200
export var Player_jump_height = 200

var value = str()
var coffee = str()
var cake = str()
var conveyor = false
var holding = null
var is_Attached = true

var Move_Right = Input.is_action_pressed("Player1_Move_Right")
var Move_Left = Input.is_action_pressed("Player1_Move_Left")
var Move_Up = Input.is_action_pressed("Player1_Move_Up")
var Move_Down = Input.is_action_pressed("Player1_Move_Down")

enum player1_Tool{
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
	Move_Up = Input.is_action_pressed("Player1_Move_Up")
	Move_Down = Input.is_action_pressed("Player1_Move_Down")
	
	var line_Position = Vector2 (self.get_position().x, self.get_position().y)
	if (player1_Tool == has_Pointer_Tool and is_Attached):
		var line = get_node("../Line2D")
		if (line != null):
			line.set_point_position (1, line_Position)
			line.update()
	
	
	if Move_Right:
		set_linear_velocity(Vector2(Player_speed,get_linear_velocity().y))
	elif Move_Left:
		set_linear_velocity(Vector2(-Player_speed,get_linear_velocity().y))
	elif Move_Up:
		set_linear_velocity(Vector2(get_linear_velocity().x, -Player_jump_height))
	elif Move_Down:
		set_linear_velocity(Vector2(get_linear_velocity().x, Player_jump_height))
	else:
		set_linear_velocity(Vector2(0,0))

func set_Attached(yesNo, container):
	if (yesNo == true):
		is_Attached = true
	else:
		is_Attached = false
		var new_Pos = get_node(String("../" + container)).position
		var line = get_node("../Line2D")
		if (line != null):
			line.set_point_position (1, new_Pos)
			line.update()

func change_Player_Sprite():
	var Player1 = get_node("Player1_Sprite")
	
	if (player1_Tool == has_CoffeeOrCake):
		if (holding == "Coffee"):
			Player1.set_texture(load("res://Art/Player1_Sprite_Plate_Coffee.png"))
		elif (holding == "Cake"):
			Player1.set_texture(load("res://Art/Player1_Sprite_Plate_Cake.png"))
		else:
			Player1.set_texture(load("res://Art/Player1_Sprite.png"))
	elif (player1_Tool == has_Pointer_Tool):
			Player1.set_texture(load("res://Art/Player1_Sprite_Pointer.png"))

func get_Player_POS():
	return get_node("../Player1").position

func add_Value(name, item):
	if (player1_Tool == has_CoffeeOrCake):
		holding = item
		if (typeof(name) == TYPE_INT):
			if (name == 1):
				value = "a"
				get_node("../Player1_Value").update_Text("Addy", "Player1")
				change_Player_Sprite()
			elif (name == 2):
				value = "b"
				get_node("../Player1_Value").update_Text("Addy", "Player1")
				change_Player_Sprite()
			elif (name == 3):
				value = "c"
				get_node("../Player1_Value").update_Text("Addy", "Player1")
				change_Player_Sprite()
			else:
				pass
		else:
			pass
		if (typeof(name) == TYPE_STRING):
			value = item
			get_node("../Player1_Value").update_Text("Addy", "Player1")
			change_Player_Sprite()
		else:
			pass
	else:
		pass

func get_Value():
	return holding

func has_Value():
	if (value != null):
		return true
	else:
		return false

func get_Value_Name():
	return value

func player1_Has_Pointer_Tool():
	if (player1_Tool == has_CoffeeOrCake):
		return false
	else:
		return true

func set_Player_State():
	var current_Level = get_tree().get_current_scene().get_name()
	if (current_Level == "0-0"):
		player1_Tool = has_CoffeeOrCake
	elif (current_Level == "0-1"):
		player1_Tool = has_CoffeeOrCake
	elif (current_Level == "0-2"):
		player1_Tool = has_CoffeeOrCake
	elif (current_Level == "0-3"):
		player1_Tool = has_CoffeeOrCake
	elif (current_Level == "1-0"):
		player1_Tool = has_Pointer_Tool
		change_Player_Sprite()