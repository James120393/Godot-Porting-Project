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
	var Player_Num = str("../" + Player)
	var Player_Value = str("../Player2_Value")
	var Player = get_node(Player_Num)
	var Value = str(Player.get_Coffee())
	var Text = str("\n" + Type + " = " + Value)
	
	get_node(Player_Value).append_bbcode(Text)

func update_Counter_Text(Type, Player):
	var Player_Num = str("../" + Player)
	var Player_Value = str("../" + Player + "_Value")
	var Player = get_node(Player_Num)
	var Value = str(Player.get_Coffee())
	var Text = str("\n" + Type + " = " + Value)
	
	get_node(Player_Value).append_bbcode(Text)
