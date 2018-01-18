extends RichTextLabel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	get_node("../Player1_Value").append_bbcode("Value = 0")
	get_node("../Player2_Value").append_bbcode("Value = 0")
	

func _process(delta):
	pass

func _update_Player2_Text():
	var Player = get_node("../Player2")
	var Value = str(Player._get_Coffee())
	var Text = str("\nValue =", Value)
	
	get_node("../Player2_Value").append_bbcode(Text)
	
func _update_Player1_Text():
	var Player = get_node("../Player1")
	var Value = str(Player._get_Coffee())
	var Text = str("\nValue =", Value)
	
	get_node("../Player1_Value").append_bbcode(Text)