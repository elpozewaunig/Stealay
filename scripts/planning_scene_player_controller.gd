extends Node

@export var player: Node3D

var PathElementScene: PackedScene = preload("res://assets/PathElement.tscn")


var current_position: Vector2i = Vector2i(0, 0)
var child_list: Array[Node3D] = []

func _on_heist_planner_add_movement(action: Globals.movement, pos: Vector2i) -> void:
	move(action)
	current_position = pos
	if action != Globals.movement.HIDE and action != Globals.movement.NULL:
		spawnTrace(player.transform.origin)
	


func _on_heist_planner_remove_last_movement(pos: Vector2i) -> void:
	revert_move(pos)
	current_position = pos


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
		pass
	# else: cry
	else:
		push_error("HUH")
	

func spawnTrace(pos: Vector3):
	#print(pos)
	var new_path_element = PathElementScene.instantiate()
	new_path_element.position = pos
	add_child(new_path_element, false)
	child_list.append(new_path_element)

func removeTrace():
	if child_list.size() > 0:
		var child: Node3D = child_list.pop_back()
		if is_instance_valid(child):
			child.queue_free()
	else: 
		push_error("Cry")
