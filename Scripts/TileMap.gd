extends TileMap

var width = 20
var height = 10
var grid = []
var file = File.new()
var textMap = ""

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