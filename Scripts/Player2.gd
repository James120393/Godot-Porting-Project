extends RigidBody2D

export var Player_speed = 200
export var Player_jump_height = 200

var coffee = String()
var cake = String()
var value = null
var holding = null

var Move_Right = Input.is_action_pressed("Player2_Move_Right")
var Move_Left = Input.is_action_pressed("Player2_Move_Left")
var Move_Up = Input.is_action_pressed("Player2_Move_Up")
var	Move_Down = Input.is_action_pressed("Player2_Move_Down")

func _ready():
	# Initalization here
	coffee = ""
	cake = ""
	
func _process(delta):
	Move_Right = Input.is_action_pressed("Player2_Move_Right")
	Move_Left = Input.is_action_pressed("Player2_Move_Left")
	Move_Up = Input.is_action_pressed("Player2_Move_Up")
	Move_Down = Input.is_action_pressed("Player2_Move_Down")
	
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


func change_Player_Sprite():
	var Player2 = get_node("Player2_Sprite")
	if (holding != null):
		var sprite_Name = String("res://Art/Player2_Sprite_Plate_" + holding + ".png")
		Player2.set_texture(load(sprite_Name))
	else:
		Player2.set_texture(load("res://Art/Player2_Sprite.png"))


#Add coffee
func add_Value(item):
	holding = item
	if (item == "Coffee"):
		value = "A"
	else:
		value = "B"
	get_node("../Player2_Value").update_Text("Val", "Player2")
	change_Player_Sprite()

#Subtract coffee
func subtract_Value():
	value = null
	change_Player_Sprite()

func get_Value():
	return value

func get_Value_Name():
	return value

func has_Value():
	if (coffee != "" or cake != ""):
		return true
	else:
		return false