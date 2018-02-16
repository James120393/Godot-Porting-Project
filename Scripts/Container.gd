extends Node2D

onready var selfName = str(self.get_name())
var coffee = str()
var cake = str()

func _process(delta):
	
	if (coffee != ""):
		get_node("Coffee_Sprite").set_visible(true)
	else:
		get_node("Coffee_Sprite").set_visible(false)


	if (cake != ""):
		get_node("Cake_Sprite").set_visible(true)
	else:
		get_node("Cake_Sprite").set_visible(false)

func _ready():
	set_process(true)

#Add coffee
func add_Coffee(name):
	if (typeof(name) == TYPE_INT):
		if (name == 1):
			coffee = "a"
			get_node("../Player2_Value").update_Counter_Text(selfName, "Coffee")
		elif (name == 2):
			coffee = "b"
			get_node("../Player2_Value").update_Counter_Text(selfName, "Coffee")
		elif (name == 3):
			coffee = "c"
			get_node("../Player2_Value").update_Counter_Text(selfName, "Coffee")
		else:
			pass
	else:
		pass
	if (typeof(name) == TYPE_STRING):
		coffee = name
		get_node("../Player2_Value").update_Counter_Text(selfName, "Coffee")
	else:
		pass

#Subtract coffee
func subtract_Coffee():
	coffee = ""

func get_Coffee():
	return coffee

#Add cake
func add_Cake(name):
	cake = name
	get_node("../Player2_Value").update_Counter_Text(selfName, "Cake")

#Subtract cake
func subtract_Cake():
	cake = ""

func get_Cake():
	return cake

func is_full():
	if (coffee != "" or cake != ""):
		return true
	else:
		return false