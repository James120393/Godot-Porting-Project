extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var game = get_parent()
	self.connect("body_entered", game, "change_Value", [self.get_name()]) ## TODO clear all but the last argument in the array then pass it to the function
	self.connect("body_exited", game, "reset_Pickup")