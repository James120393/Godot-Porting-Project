extends Node2D

var coffee = str()
var cake = str()

func _process(delta):
	
	if (coffee != ""):
		get_node("Coffee_Sprite").set_hidden(false)
	else:
		get_node("Coffee_Sprite").set_hidden(true)


	if (cake != ""):
		get_node("Cake_Sprite").set_hidden(false)
	else:
		get_node("Cake_Sprite").set_hidden(true)

func _ready():
	set_process(true)

#Add coffee
func add_Coffee(name):
	coffee = name

#Subtract coffee
func subtract_Coffee():
	coffee = " "

func get_Coffee():
	return coffee

#Add cake
func add_Cake(name):
	cake = name

#Subtract cake
func subtract_Cake():
	cake = " "

func get_Cake():
	return cake

func is_full():
	if (coffee != " " or cake != " "):
		return true
	else:
		return false