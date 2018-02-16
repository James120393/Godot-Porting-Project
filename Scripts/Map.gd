extends TileMap

var tile_Size = get_cell_size()
var half_Tile_Size = tile_Size / 2

var grid_Size = get_node("TileMap").
var grid = []

func _ready():
	for x in range(grid_Size.x):
		grid.append([])
		for y in range(grid_Size.y):
			grid[x].append(null)
		
	pass
	
