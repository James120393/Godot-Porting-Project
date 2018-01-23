extends RigidBody2D

export var Player_speed = 200

var coffee = int()

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
	
	if (_get_Coffee() >= 1):
		Player1.set_texture(load("res://Art/Player1-Sprite-Plate-Cofee.png"))
	else:
		Player1.set_texture(load("res://Art/Player1-Sprite.png"))

func get_Player_POS():
	return get_node("../Player1").get_pos()

#Add coffee
func addCoffee():
	coffee += 1
	get_node("../Player1_Value")._update_Player1_Text()

#Subtract coffee
func subtractCoffee():
	coffee -= 1
	get_node("../Player1_Value")._update_Player1_Text()

func _get_Coffee():
	return coffee