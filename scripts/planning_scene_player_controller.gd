extends Node

@export var player: Node3D


var current_position: Vector2i = Vector2i(0, 0)

func _on_heist_planner_add_movement(action: Globals.movement, pos: Vector2i) -> void:
	move(action)
	current_position = pos
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
	# 14, 7 -> 15, 7 -> -1, 0 -> move right
	elif difference == Vector2i(-1, 0):
		move(Globals.movement.UP)
	# 14, 7 -> 14, 6 -> 0, 1 -> move down
	elif difference == Vector2i(0, 1):
		move(Globals.movement.LEFT)
	# 14, 7 -> 14, 8 -> 0, -1 -> move up
	elif difference == Vector2i(0, -1):
		move(Globals.movement.RIGHT)
	# 14, 7 -> 14, 7 -> 0, 0 -> removed hide, do nothing
	elif difference == Vector2i(0, 0):
		pass
	# else: cry
	else:
		push_error("HUH")
	

func spawnTrace(pos):
	print(pos)
