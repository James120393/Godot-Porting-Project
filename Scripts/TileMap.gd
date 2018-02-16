extends TileMap

var width = 20
var height = 10
var grid = []
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	for x in range(0, width):
		grid.append([])
		for y in range(0, height):
			grid[x].append(0)
			print (self.get_cell(x,y))
			set_cell(x,y,1)
	#print (grid)
	#print(self.get_used_cells())

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
