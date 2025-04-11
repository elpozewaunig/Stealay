extends Node

@export var guard_list: Array[Node3D] = []

var delay: float = 1.5
var time_passed: float = 0.0

var movecount: int = 0


func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if time_passed >= delay:
		time_passed = 0.0
		move()
	
	time_passed += delta


func move() -> void: 
	for guard in guard_list:
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
	
	movecount+=1
		
