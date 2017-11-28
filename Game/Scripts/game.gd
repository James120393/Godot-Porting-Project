#extends Node2D

# Member variables
#var screen_size
#var direction = Vector2(1.0, 0.0)

# Constant for player speed
#const Player_Speed = 300

#func _ready():
  #  screen_size = get_viewport_rect().size
   # set_process(true)

#func _process(delta):

	# Move player1
	#var Player1_pos = get_node("Player1").get_pos() 

	#if (Player1_pos.x > 0 and Input.is_action_pressed("Player1_Move_Left")):
	#	Player1_pos.x += -Player_Speed * delta
	#if (Player1_pos.x < screen_size.x and Input.is_action_pressed("Player1_Move_Right")):
	#	Player1_pos.x += Player_Speed * delta
	
	# Move player2
	#var Player2_pos = get_node("Player2").get_pos()

	#if (Player2_pos.x > 0 and Input.is_action_pressed("Player2_Move_Left")):
	#	Player2_pos.x += -Player_Speed * delta
	#if (Player2_pos.x < screen_size.x and Input.is_action_pressed("Player2_Move_Right")):
	#	Player2_pos.x += Player_Speed * delta

	#get_node("Player2").set_pos(Player2_pos)