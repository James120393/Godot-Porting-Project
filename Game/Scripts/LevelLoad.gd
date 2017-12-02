extends RichTextLabel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var levelRaw = []
var levelNumber = 0

func _ready():
# Read in level file
	# Check if there is a saved file
	var file = File.new()
	if not file.file_exists("res://Resources/Levels/level0-0.txt"):
    	print("No file saved!")
    	return

	# Open existing file
	if file.open("res://Resources/Levels/level0-0.txt", File.READ) != 0:
    	print("Error opening file")
    	return
	
	# Load data
	levelRaw.append(file.get_line())
	
	#display raw level
	set_bbcode(levelRaw[levelNumber])
	print(levelRaw[levelNumber])
	set_visible_characters(-1)
