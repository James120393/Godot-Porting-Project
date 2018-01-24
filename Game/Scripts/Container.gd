extends Node2D

var coffee = int()

func _process(delta):
	
	if (coffee >= 1):
		get_node("Coffee_Sprite").set_hidden(false)
	else:
		get_node("Coffee_Sprite").set_hidden(true)

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