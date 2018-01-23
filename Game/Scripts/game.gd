extends Control

var CanPickUp = false

#var areas = []

var state = {
	trans = Tween.TRANS_LINEAR,
	eases = Tween.EASE_IN,
}

func getallnodes():
	var node = get_node("Area_Parent")
	for N in node.get_children():
		if N.get_child_count() > 0:
			getallnodes(N)
		else:
			pass

func _check_area():
	var areas = [Area_Parent]

	for area in areas:
		area.get_overlapping_bodies()
		for obj in area:
			if (obj.get_name() == "Player2"):
				return "Player2"
		return false
	return false
	

func _ready():
	#set_process(true)
	set_process_input(true)
	set_process(true)

# Funtion to detect input events
func _input(event):
	var collision = get_node("Area1").get_overlapping_bodies()
	
	if (Input.is_action_pressed("Player2_Pickup") and _check_area() == "Player2"):
		_On_Pickup_Button_Pressed()
	else:
		pass


func _check_collision(collision):
	for obj in collision:
		if (obj.get_name() == "Player2"):
			return true
	return false

	if get_node("Play").is_pressed():
		_on_play_Button_pressed()

# Called every frame
func _process(delta):
	var Player1_pos = get_node("Player1").get_pos() 
	var player_pos = get_node("Player2").get_pos()
	var coffee_pos = get_node("Tween/Coffee").get_pos()
	var distance = coffee_pos.distance_to(player_pos)
	
	if (distance <= 5):
		get_node("Tween").stop_all()
		get_node("Player2").addCoffee()
		get_node("Tween").reset_all()
	else:
		pass


func _On_Pickup_Button_Pressed():
	var tween = get_node("Tween")
	var coffee = get_node("Tween/Coffee")
	var follow = get_node("Player2")
	var origin = get_node("Coffee_Dis").get_pos()
	
	tween.follow_method(coffee, "set_pos", origin, follow, "get_pos", 2, state.trans, state.eases)
	tween.targeting_method(coffee, "set_pos", follow, "get_pos", origin, 2, state.trans, state.eases, 2)
	tween.start()



func _on_play_Button_pressed():
	get_node("Info").set_hidden(true)
	get_node("Play").set_disabled(true)
	get_node("Play").set_hidden(true)

# Spawn a new coffee
func new_Coffee():
	pass
#	var Player2_pos = get_node("Player2").get_pos()
#	# Declare Variables by calling the new() function
#	var spawn_Coffee = Node2D.new()
#	var coffee_Sprite  = Sprite.new()
#	
#	# Set the two node to be a child of the scene
#	get_node("Coffee_Dis").add_child(spawn_Coffee)
#	spawn_Coffee.add_child(coffee_Sprite)
#	
#	# Set the owner of the new nodes
#	spawn_Coffee.set_owner(get_node("Coffee_Dis"))
#	coffee_Sprite.set_owner(spawn_Coffee)
#	
#	# Load the texture and set the scale/Position
#	coffee_Sprite.set_texture(load("res://Art/Cup.png"))
#	spawn_Coffee.set_scale(Vector2(0.5,0.5))
#	spawn_Coffee.set_pos(Player2_pos)