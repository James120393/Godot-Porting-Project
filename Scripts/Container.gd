extends Node2D

onready var selfName = str(self.get_name())
onready var coffee_Node = get_node("Coffee_Sprite")
onready var cake_Node = get_node("Cake_Sprite")
onready var line = get_node("../Line2D")
onready var t_Coffee = get_node("../Tween/Tween_Coffee")
onready var tween = get_node("../Tween")

var check_Move = true
var value = null
var contains = null
var true_Value = null
var pointer_Attached = false

var state = {
	trans = Tween.TRANS_LINEAR,
	eases = Tween.EASE_IN,
}

enum container_State{
	none,
	has_CoffeeOrCake,
	has_Pointer_Tool
}

func _process(delta):
	
	if (contains != null):
		if (contains == "Coffee"):
			coffee_Node.set_visible(true)
			true_Value = "A"
		else:
			coffee_Node.set_visible(false)
		if (contains == "Cake"):
			cake_Node.set_visible(true)
			true_Value = "B"
		else:
			cake_Node.set_visible(false)

	# Check distance from the moving sprite to the player to detect
	# when the sprite should stop
	if (pointer_Attached == true and self.has_Value() == true and check_Move == true):
		var t_coffe_Position = t_Coffee.position
		var line_Position = line.get_start_position()
		var Distance_Coffee = t_coffe_Position.distance_to(line_Position)
		if (Distance_Coffee <= 5):
			t_Coffee.set_visible(false)
			tween.stop_all()
			#var nodes = get_tree().get_nodes_in_group("Container")
			#var distances = []
			#for i in nodes:
			#	distances.append(t_coffe_Position.distance_to(i))
			#distances.sort()
			#distances.invert()
			#var closest_object = distances.front()
			#if closest_object != null:
			#	closest_object.add_Coffee()
			#tween.stop_all()
			get_node("../*q").set_Value("Val")
			get_node("../Player2_Value").update_Counter_Text("*q", "Coffee")
			check_Move = false
		else:
			pass

func _ready():
	set_process(true)
	container_State = has_Pointer_Tool

func attach_Pointer():
	pointer_Attached = true

func move_sprite():
		var origin = self.position
		t_Coffee.set_visible(true)
		tween.follow_method(t_Coffee, "set_position", origin, line, "get_start_position", 0.5, state.trans, state.eases)
		tween.targeting_method(t_Coffee, "set_position", line, "get_start_position", origin, 0.5, state.trans, state.eases, 2)
		tween.start()

#Add value to the container, so it can only contain either a coffe or cake
func add_Value(name, item):
	if (container_State == has_Pointer_Tool):
		contains = item
		if (typeof(name) == TYPE_INT):
			if (name == 1):
				value = "a"
				get_node("../Player2_Value").update_Counter_Text(selfName, item)
			elif (name == 2):
				value = "b"
				get_node("../Player2_Value").update_Counter_Text(selfName, item)
			elif (name == 3):
				value = "c"
				get_node("../Player2_Value").update_Counter_Text(selfName, item)
			else:
				pass
		else:
			pass
		if (typeof(name) == TYPE_STRING):
			value = name
			get_node("../Player2_Value").update_Counter_Text(selfName, item)
		else:
			pass
	else:
		pass

func get_Value():
	return value

func get_True_Value():
	return true_Value

func set_Value(val):
	value = val

func has_Value():
	if (value != null):
		return true
	else:
		return false