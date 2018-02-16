extends TileMap

var width = 20
var height = 10
var grid = []
var file = File.new()
var textMap = ""
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	print (width)
	for x in range(0, width):
		grid.append([])
		for y in range(0, height):
			grid[x].append(0)
			set_cell(x,y,3)
			
			#test new file reading
			if file.file_exists("res://Game/Resources/Levels/level0-0.txt"):
				file.open("res://Game/Resources/Levels/level0-0.txt", file.READ)
				textMap = file.get_as_text()
				file.close()
			print (textMap)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
