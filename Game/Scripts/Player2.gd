extends RigidBody2D

export var Player_speed = 200
export var Player_jump_height = 200

var coffee = str()
var cake = str()

var Move_Right = Input.is_action_pressed("Player2_Move_Right")
var Move_Left = Input.is_action_pressed("Player2_Move_Left")
var Jump = Input.is_action_pressed("Player2_Jump")

func _ready():
	# Initalization here
	coffee = 0
	set_fixed_process(true)
	
func _fixed_process(delta):
	Move_Right = Input.is_action_pressed("Player2_Move_Right")
	Move_Left = Input.is_action_pressed("Player2_Move_Left")
	Jump = Input.is_action_pressed("Player2_Jump")
	
	if Move_Right:
		set_linear_velocity(Vector2(Player_speed,get_linear_velocity().y))
	elif Move_Left:
		set_linear_velocity(Vector2(-Player_speed,get_linear_velocity().y))
	elif Jump:
		set_linear_velocity(Vector2(get_linear_velocity().x, -Player_jump_height))
	else:
		set_linear_velocity(Vector2(0,get_linear_velocity().y))


func change_Player_Sprite():
	var Player2 = get_node("Player2_Sprite")
	
	if (get_Coffee() == "A"):
		Player2.set_texture(load("res://Art/Player2_Sprite_Plate_Coffee.png"))
	elif (get_Cake() == "B"):
		Player2.set_texture(load("res://Art/Player2_Sprite_Plate_Cake.png"))
	else:
		Player2.set_texture(load("res://Art/Player2_Sprite.png"))

#Add coffee
func add_Coffee():
	coffee = "A"
	get_node("../Player2_Value").update_Text("Val", "Player2")
	change_Player_Sprite()

#Subtract coffee
func subtract_Coffee():
	coffee = " "
	change_Player_Sprite()

func get_Coffee():
	return coffee

#Add cake
func add_Cake():
	cake = "B"
	get_node("../Player2_Value").update_Text("Val", "Player2")
	change_Player_Sprite()

#Subtract cake
func subtract_Cake():
	cake = " "
	get_node("../Player2_Value").update_Text("Val", "Player2")
	change_Player_Sprite()

func get_Cake():
	return cake