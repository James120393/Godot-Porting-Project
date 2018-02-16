extends RichTextLabel

# class member variables go here, for example:


func _ready():

	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)


func _process(delta):
	pass

#func _update_Player2_Text(Type):
#	var Player = get_node("../Player2")
#	var Value = str(Player.get_Coffee())
#	var Text = str("\n" + Type + "Value =" + Value)

#	get_node("../Player2_Value").append_bbcode(Text)

#func _update_Player1_Text(Type):
#	var Player = get_node("../Player1")
#	var Value = str(Player.get_Coffee())
#	var Text = str("\n" + Type + "Value =" + Value)

#	get_node("../Player1_Value").append_bbcode(Text)

func update_Text(Type, Player):
	#Get the player node
	var Player_Num = get_node("../" + Player)
	#Get the text box
	var Player_Value = String("../Player2_Value")
	#Get the coffe value
	var Value = String(Player_Num.get_Coffee())
	#Convert it all into a single string
	var Text = String("\n" + Type + " = " + Value)
	
	get_node(Player_Value).append_bbcode(Text)

func update_Counter_Text(Type, Player):
	var Player_Num = get_node("../" + Player)
	var Player_Value = String("../" + Player + "_Value")
	var Value = String(Player_Num.get_Coffee())
	var Text = String("\n" + Type + " = " + Value)
	
	get_node(Player_Value).append_bbcode(Text)
