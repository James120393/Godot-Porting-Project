extends Navigation2D

# Member variables
const start = Vector2(120, 649)
const SPEED = 800.0

var begin = Vector2()
var end = Vector2()
var path = []

func _process(delta):
	var Player1 = get_node("../Player1")
	var Coffee = get_node("Coffee_Sprite")
	
	if (path.size() > 1):
		Coffee.set_hidden(false)
		var to_walk = delta*SPEED
		while(to_walk > 0 and path.size() >= 2):
			var pfrom = path[path.size() - 1]
			var pto = path[path.size() - 2]
			var d = pfrom.distance_to(pto)
			if (d <= to_walk):
				path.remove(path.size() - 1)
				to_walk -= d
			else:
				path[path.size() - 1] = pfrom.linear_interpolate(pto, to_walk/d)
				to_walk = 0

		var atpos = path[path.size() - 1]
		Coffee.set_pos(atpos)

		if (path.size() < 2):
			path = []
			set_process(false)
#			Player1.change_Player_Sprite()
			Player1.addCoffee()										#add coffee to player 2
			print (str(Player1.coffee))
			Coffee.set_hidden(true)

	else:
		set_process(false)


func _update_path():
	var p = get_simple_path(begin, end, true)
	path = Array(p) # Vector2array too complex to use, convert to regular array
	path.invert()

	set_process(true)


func _input(event):
	if (Input.is_action_pressed("Player1_Pickup")):
		begin = get_node("../Coffee_Con").get_pos()
		# Mouse to local navigation coordinates
		end = get_node("../Player1").get_pos() - get_pos()
		_update_path()

	if (Input.is_action_pressed("Player1_Drop")):
		begin = get_node("../Player1").get_pos()
		# Mouse to local navigation coordinates
		# Need to add functionailty to detect tile location
		end = get_node("../Player2").get_pos() - get_pos()
		_update_path()


func _ready():
	set_process_input(true)
