extends Node

@export var guard_list: Array[Node3D] = []


var time_passed: float = 0.0

var movecount: int = 0


func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if time_passed >= Globals.time_between_moves:
		time_passed = 0.0
		move()
	
	time_passed += delta


func move() -> void: 
	for guard in guard_list:
		# constantly cvhecks if player is in sight
		# move
		if guard.on_patrol:
			# guard is patroling
			patrol(guard)
		else:
			# guard is Kruskalin
			kruskal(guard)
	
	movecount+=1


func patrol(guard: Node3D) -> void:
	var sequence: Array[Globals.movement] = guard.input_sequence
	var i: int  = movecount%len(sequence)
	var current_move: Globals.movement = sequence[i]
		
	if (current_move == Globals.movement.UP):
		guard.moveUp()
	elif (current_move == Globals.movement.DOWN):
		guard.moveDown()
	elif (current_move == Globals.movement.RIGHT):
		guard.moveRight()
	elif (current_move == Globals.movement.LEFT):
		guard.moveLeft()
	
	
func kruskal(guard: Node3D) -> void:
	pass
