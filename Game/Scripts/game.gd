extends Navigation2D

# Member variables
const start = Vector2(120, 649)
const SPEED = 800.0

var begin = Vector2()
var end = Vector2()
var path = []
var CanPickUp = false

func _ready():
	#set_process(true)
	set_process_input(true)

# Funtion to detect input events
func _input(event):
	if (Input.is_action_pressed("Player2_Pickup")):
		_On_Pickup_Button_Pressed()

	if get_node("Play").is_pressed():
		_on_play_Button_pressed()

# Called every frame
func _process(delta):
	var Player1_pos = get_node("Player1").get_pos() 
	var Collision = get_node("Area2D")


func _On_Pickup_Button_Pressed():
	new_Coffee()

func _on_play_Button_pressed():
	get_node("Info").set_hidden(true)
	get_node("Play").set_disabled(true)
	get_node("Play").set_hidden(true)

# Spawn a new coffee
func new_Coffee():
	var Player2_pos = get_node("Player2").get_pos()
	# Declare Variables by calling the new() function
	var spawn_Coffee = Node2D.new()
	var coffee_Sprite  = Sprite.new()
	
	# Set the two node to be a child of the scene
	get_node("Coffee_Dis").add_child(spawn_Coffee)
	spawn_Coffee.add_child(coffee_Sprite)
	
	# Set the owner of the new nodes
	spawn_Coffee.set_owner(get_node("Coffee_Dis"))
	coffee_Sprite.set_owner(spawn_Coffee)
	
	# Load the texture and set the scale/Position
	coffee_Sprite.set_texture(load("res://Art/Cup.png"))
	spawn_Coffee.set_scale(Vector2(0.5,0.5))
	spawn_Coffee.set_pos(Player2_pos)