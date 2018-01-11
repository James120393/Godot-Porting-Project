extends RigidBody2D

export var Player_speed = 200
export var Player_jump_height = 200

var coffee = int()

var Move_Right = Input.is_action_pressed("Player2_Move_Right")
var Move_Left = Input.is_action_pressed("Player2_Move_Left")
var Jump = Input.is_action_pressed("Player2_Jump")

onready var Plr2_pos = get_node("Player2_Sprite").get_pos()

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
		
		
func _Get_Player2_Pos():
	return get_node("Player2").get_pos()

#Add coffee
func addCoffee():
	coffee += 1
	
#Subtract coffee
func subtractCoffee():
	coffee -= 1