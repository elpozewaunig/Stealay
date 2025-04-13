extends Node

@export var player: Node3D

var PathElementScene: PackedScene = preload("res://assets/PathElement.tscn")
var HideElementScene: PackedScene = preload("res://assets/HideElement.tscn")
var SkullElementScene: PackedScene = preload("res://assets/SkullElement.tscn")

@onready
var current_position: Vector2i
var child_list: Array[Node3D] = []

var dev_mode: bool = Globals.dev_mode
var pos_list: Array[Vector2i] 
var dev_mode_list: Array[Vector2i] 

func _ready() -> void:
	current_position=  calculate_pos_vector_from_global_pos()
	pos_list= [current_position]

func _on_heist_planner_add_movement(action: Globals.movement, pos: Vector2i) -> void:
	move(action)
	if dev_mode:
		print(pos)
	current_position = pos
	if action != Globals.movement.NULL:
		var glob_pos: Vector3 = player.transform.origin
		#glob_pos =  calculate_global_position_from_pos(pos)
		spawnTrace(glob_pos, action)
	
	if dev_mode:
		pos_list.append(pos)
	


func _on_heist_planner_remove_last_movement(pos: Vector2i) -> void:
	revert_move(pos)
	current_position = pos
	if dev_mode:
		if pos_list.size() > 1:
			pos_list.pop_back()



func move(current_move: Globals.movement):
	if (current_move == Globals.movement.UP):
		player.moveUp()
	elif (current_move == Globals.movement.DOWN):
		player.moveDown()
	elif (current_move == Globals.movement.RIGHT):
		player.moveRight()
	elif (current_move == Globals.movement.LEFT):
		player.moveLeft()
		

func revert_move(new_position: Vector2i):
	var difference: Vector2i = current_position - new_position
	# 14, 7 -> 13, 7 -> 1, 0 -> move left
	if difference == Vector2i(1, 0):
		move(Globals.movement.DOWN)
		removeTrace()
	# 14, 7 -> 15, 7 -> -1, 0 -> move right
	elif difference == Vector2i(-1, 0):
		move(Globals.movement.UP)
		removeTrace()
	# 14, 7 -> 14, 6 -> 0, 1 -> move down
	elif difference == Vector2i(0, 1):
		move(Globals.movement.LEFT)
		removeTrace()
	# 14, 7 -> 14, 8 -> 0, -1 -> move up
	elif difference == Vector2i(0, -1):
		move(Globals.movement.RIGHT)
		removeTrace()
	# 14, 7 -> 14, 7 -> 0, 0 -> removed hide, do nothing
	elif difference == Vector2i(0, 0):
		removeTrace()
	# else: cry
	else:
		push_error("HUH")
	

func spawnTrace(pos: Vector3, action):
	#print(pos)
	var new_path_element
	if action != Globals.movement.HIDE:
		new_path_element = PathElementScene.instantiate()
		new_path_element.position = pos
		new_path_element.position.y -= 1.02
	else: 
		new_path_element = HideElementScene.instantiate()
		new_path_element.position = pos
		new_path_element.position.y -= 1.01

	add_child(new_path_element, false)
	child_list.append(new_path_element)

func removeTrace():
	if child_list.size() > 0:
		var child: Node3D = child_list.pop_back()
		if is_instance_valid(child):
			child.queue_free()
	else: 
		push_error("Cry")
		

func _input(event: InputEvent) -> void:
	if not dev_mode:
		return
		
	if not event.is_pressed():
		return
	
	if event.is_action("PrintPositionInDevMode", true):
		dev_mode_list.append(current_position)
		
func _on_heist_planner_heist_planned(sequence: Variant) -> void:
	if dev_mode:
		print("Sequence of Path: ")
		print(sequence)
		
		print("Visited positions: ")
		var pos_set: Array[Vector2i] = []
		for pos in pos_list:
			if pos not in pos_set:
				pos_set.append(pos)
		
		#pos_set.sort()
		print(pos_set)
		
		print("Dev List")
		print(dev_mode_list)


func _on_heist_planner_place_skull(pos: Vector2i) -> void:
	
	var glob_pos: Vector3 = calculate_global_position_from_pos(pos)
	var new_path_element = SkullElementScene.instantiate()
	new_path_element.position = glob_pos
	new_path_element.position.y -= 1

	add_child(new_path_element, false)



func calculate_global_position_from_pos(pos: Vector2i) -> Vector3:
	var myPosition: Vector3 = Vector3(0, 0, 0)
	myPosition.x = pos.y
	myPosition.z = -pos.x
	
	return myPosition
	
func calculate_pos_vector_from_global_pos() -> Vector2i:
	var position: Vector2i = Vector2i(0, 0)
	position.y = player.transform.origin.x
	position.x = -player.transform.origin.z
	return position
