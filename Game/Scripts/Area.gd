extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var game = get_parent()
	self.connect("body_enter_shape", game, "change_Value", [get_name()]) ## TODO clear all but the last argument in the array then pass it to the function
	self.connect("body_exit_shape", game, "reset_Pickup")