extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	

# Temp Function
func _process(delta):
	var Player = get_node("../Player2")
	var Value = str(Player._get_Coffee())
	var Text = str("Value =", Value)
	
	self.set_text(Text)