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
	

	# apply aesthetic layout to level
	var position
	var positionModifier
	for y in range(0, tileMapTextArray.size()):
		for x in range(0, tileMapTextArray[y].length()):
			#determine which tile to place
			if tileMapTextArray[y][x] == "-":
				set_cell(x,y,1)
			elif tileMapTextArray[y][x] == "+":
				set_cell(x,y,1)
				
			# position players
			elif tileMapTextArray[y][x] == "*":
				position = map_to_world(Vector2(x,y))
				get_parent().get_node("Player2").set_global_position(position)
				set_cell(x,y,3)
			elif tileMapTextArray[y][x] == "&":
				position = map_to_world(Vector2(x,y))
				get_parent().get_node("Player1").set_global_position(position)
				set_cell(x,y,3)
			
			# place values
			elif tileMapTextArray[y][x] == "A":
				position = map_to_world(Vector2(x,y))
				positionModifier = Vector2(32,80)
				get_parent().get_node("Tween/Tween_Coffee").set_global_position(position + positionModifier)
				# pickup collider
				positionModifier = Vector2(32,0)
				get_parent().get_node("Bottom_Left").set_global_position(position + positionModifier)
				set_cell(x,y,2)
			
			elif tileMapTextArray[y][x] == "x":
				position = map_to_world(Vector2(x,y))
				positionModifier = Vector2(32,80*2)
				get_parent().get_node("Under_Left/CollisionShape2D").set_global_position(position + positionModifier)
				set_cell(x,y,8)
			
			# place background tiles in empty space
			else:
				set_cell(x,y,3)