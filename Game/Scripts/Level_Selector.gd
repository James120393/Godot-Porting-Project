extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var Menu = get_parent().get_parent().get_parent().get_parent().get_parent()
	# Called every time the node is added to the scene.
	# Initialization here
	self.connect("released", Menu, "load_Level", [str(self.get_name())])