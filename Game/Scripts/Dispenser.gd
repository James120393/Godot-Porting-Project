extends KinematicBody2D

# Member variables
#const speed = 8.0

#var begin = Vector2()
#var end = Vector2()
#var path = []

#var Visible = true
#var Add = true

#var Player = null
#var Coffee = null
#var Text = null

func _process(delta):
	pass
	#if (path.size() > 1):
		#Coffee.set_hidden(false)
#		var angle = get_rot() - PI/2.0
#		var dir = Vector2(cos(angle), - sin(angle))

#		var to_walk = delta*SPEED
#		while(to_walk > 0 and path.size() >= 2):
#			var pfrom = path[path.size() - 1]
#			var pto = path[path.size() - 2]
#			var d = pfrom.distance_to(pto)
#			if (d <= to_walk):
#				path.remove(path.size() - 1)
#				to_walk -= d
#			else:
#				path[path.size() - 1] = pfrom.linear_interpolate(pto, to_walk/d)
#				to_walk = 0
#
#		var atpos = path[path.size() - 1]
#		Coffee.set_global_pos(atpos)
#
#		if (path.size() < 2):
#			path = []
#			set_process(false)
#			if (Add == true):
#				Player.addCoffee()										#add coffee to player 2
#			else:
#				Player.subtractCoffee()
#			Player.change_Player_Sprite()
#			Coffee.set_hidden(Visible)
#			Text._update_Player2_Text()
#			print (str(Player.coffee))
#
#	else:
#		set_process(false)



#func _update_path():
#	var p = get_simple_path(begin, end, true)
#	path = Array(p) # Vector2array too complex to use, convert to regular array
#	path.invert()

#	set_process(true)


func _input(event):
	pass
#	var Player2_POS = get_node("../Player2").get_pos()
#	var Player1_POS = get_node("../Coffee_Con").get_pos()
#	
#	if (Input.is_action_pressed("Player2_Pickup")):
#		begin = self.get_pos()
#		# Mouse to local navigation coordinates
#		end = Player2_POS - get_pos()
#		
#		Player = get_node("../Player2")
#		Text = get_node("../Player2_Value")
#		Coffee = get_node("Coffee_Sprite")
#		Visible = true
#		Add = true
#		
#		_update_path()
#
#	if (Input.is_action_pressed("Player2_Drop") and get_node("../Player2")._get_Coffee() >= 1):
#		begin = Player2_POS
#		# Mouse to local navigation coordinates
#		end = Player1_POS - get_pos()
#
#		Player = get_node("../Player1")
#		Text = get_node("../Player1_Value")
#		Coffee = get_node("Coffee_Sprite")
#		Visible = false
#		Add = false

#		_update_path()
#
#
func _ready():
	set_process_input(true)
