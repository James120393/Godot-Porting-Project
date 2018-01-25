extends RigidBody2D

export var Player_speed = 200

var coffee = int()
var cake = int()

var Move_Right = Input.is_action_pressed("Player1_Move_Right")
var Move_Left = Input.is_action_pressed("Player1_Move_Left")

func _ready():
	# Initalization here
	set_fixed_process(true)
	
func _fixed_process(delta):
	Move_Right = Input.is_action_pressed("Player1_Move_Right")
	Move_Left = Input.is_action_pressed("Player1_Move_Left")
	
	if Move_Right:
		set_linear_velocity(Vector2(Player_speed,get_linear_velocity().y))
	elif Move_Left:
		set_linear_velocity(Vector2(-Player_speed,get_linear_velocity().y))
	else:
		set_linear_velocity(Vector2(0,get_linear_velocity().y))

func change_Player_Sprite():
	var Player1 = get_node("Player1_Sprite")
	
	if (get_Coffee() >= 1):
		Player1.set_texture(load("res://Art/Player1_Sprite_Plate_Coffee.png"))
	elif (get_Cake() >= 1):
		Player1.set_texture(load("res://Art/Player1_Sprite_Plate_Cake.png"))
	else:
		Player1.set_texture(load("res://Art/Player1_Sprite.png"))

func get_Player_POS():
	return get_node("../Player1").get_pos()

#Add coffee
func add_Coffee():
	coffee += 1
	get_node("../Player1_Value").update_Text("Coffee", "Player1")
	change_Player_Sprite()

#Subtract coffee
func subtract_Coffee():
	coffee -= 1
	get_node("../Player1_Value").update_Text("Coffee", "Player1")
	change_Player_Sprite()

func get_Coffee():
	return coffee

#Add cake
func add_Cake():
	cake += 1
	get_node("../Player1_Value").update_Text("Cake", "Player1")
	change_Player_Sprite()

#Subtract cake
func subtract_Cake():
	cake -= 1
	get_node("../Player1_Value").update_Text("Cake", "Player1")
	change_Player_Sprite()

func get_Cake():
	return cake