extends Line2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func get_end_position():
	var pos = self.get_point_position(1)
	return pos

func get_start_position():
	var pos = self.get_point_position(0)
	return pos
