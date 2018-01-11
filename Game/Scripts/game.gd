extends Navigation2D

# Member variables
const start = Vector2(120, 649)
const SPEED = 800.0

var begin = Vector2()
var end = Vector2()
var path = []

func _ready():
	#screen_size = get_viewport_rect().size
	#set_process(true)
	set_process_input(true)

func _process(delta):
	var CanPickUp = false
	
	#var tile_pos = TileMap.world_to_map(global_pos)
	#var cell = TileMap.get_cellv(tile_pos)
	#var cell_pos = cell.get_pos()
	var Player1_pos = get_node("Player1").get_pos() 
	var Player2_pos = get_node("Player2").get_pos()
		
	#if (cell == 4): # thetilesets tile id
	#	tilemap.set_cellv(tile_pos, 4)
	
	#if ((Player2_pos - cell_pos) < 20):
	#	return bool ('true')

	if (Input.is_action_pressed("Player2_Pickup")):
		_On_Pickup_Button_Pressed()

	if (path.size() > 1):
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
		get_node("Coffee_Sprite").set_pos(atpos)
		
		if (path.size() < 2):
			path = []
			set_process(false)
			_Change_Player_Sprite()
			get_node("Player2").addCoffee()												#add coffee to player 2
			print (str(get_node("Player2").coffee))
			
	else:
		set_process(false)

func _On_Pickup_Button_Pressed():
	return
	
func _update_path():
	var p = get_simple_path(begin, end, true)
	path = Array(p) # Vector2array too complex to use, convert to regular array
	path.invert()
	
	set_process(true)

func _input(event):
	var Player2_pos = get_node("Player2").get_pos()
	
	if (Input.is_action_pressed("Player2_Pickup")):
		begin = get_node("Coffee_Sprite").get_pos()
		# Mouse to local navigation coordinates
		end = Player2_pos - get_pos()
		_update_path()

func _Change_Player_Sprite():
	var Player2 = get_node("Player2/Player2_Sprite")
	Player2.set_texture(load("res://Art/Player2-Sprite-Plate-Cofee.png"))
