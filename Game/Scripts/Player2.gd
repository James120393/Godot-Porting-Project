extends RigidBody2D

export var Player_speed = 200
export var Player_jump_height = 200

var Move_Right = Input.is_action_pressed("Player2_Move_Right")
var Move_Left = Input.is_action_pressed("Player2_Move_Left")
var Jump = Input.is_action_pressed("Player2_Jump")

func _ready():
	# Initalization here
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

