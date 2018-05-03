extends TileMap

var width = 20
var height = 10
var file = File.new()
var textMap = ""
var lineArray
var tileMapTextArray = []


func _ready():
	print (width)
	for x in range(0, width):
		for y in range(0, height):
			set_cell(x,y,3)
			
	#test new file reading
	if file.file_exists("res://Game/Resources/Levels/level0-0.txt"):
		file.open("res://Game/Resources/Levels/level0-0.txt", file.READ)
		textMap = file.get_as_text()
		file.close()
		lineArray = textMap.split("\n")
	
	# seperates aesthetic information
	var isIntialMap = false
	for i in lineArray:
		if i == "; Initial Layout":
			isIntialMap = true
		if i.begins_with("-") and isIntialMap == true:
			tileMapTextArray.append(i)
		if i == "; Target Layout":
			isIntialMap = false
	print(tileMapTextArray)
	
	var player2pos
	
	
	# apply aesthetic layout to level
	for y in range(0, tileMapTextArray.size()):
		for x in range(0, tileMapTextArray[y].length()):
			#determine which tile to place
			if tileMapTextArray[y][x] == "-":
				set_cell(x,y,1)
			elif tileMapTextArray[y][x] == "+":
				set_cell(x,y,1)
			elif tileMapTextArray[y][x] == "*":
				player2pos = Vector2(x,y)					#TODO: make multiplier unnecessary Something to do with the tilemap going off screen
			elif tileMapTextArray[y][x] == "&":
				var position = map_to_world(Vector2(x,y))
				print(position)
				get_parent().get_node("Player1").set_global_position(position)
			else:
				set_cell(x,y,3)
	
	
	#place objects only once the grid has reached it's final size
	get_parent().get_node("Player2").set_global_position(map_to_world(player2pos))