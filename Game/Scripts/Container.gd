extends Node2D

var coffee = int()
var cake = int()

func _process(delta):
	
	if (coffee >= 1):
		get_node("Coffee_Sprite").set_hidden(false)
	else:
		get_node("Coffee_Sprite").set_hidden(true)


	if (cake >= 1):
		get_node("Cake_Sprite").set_hidden(false)
	else:
		get_node("Cake_Sprite").set_hidden(true)

func _ready():
	set_process(true)

#Add coffee
func add_Coffee():
	coffee += 1

#Subtract coffee
func subtract_Coffee():
	coffee -= 1

func get_Coffee():
	return coffee

#Add cake
func add_Cake():
	cake += 1

#Subtract cake
func subtract_Cake():
	cake -= 1

func get_Cake():
	return cake

func is_full():
	if (coffee >= 1 or cake >= 1):
		return true
	else:
		return false