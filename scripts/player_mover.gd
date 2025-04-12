extends Node

@export var player: Node3D
@export var input_sequence: Array[Globals.movement] = []

var delay: float = Globals.time_between_moves
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
	change_position()
	check_if_won()


func change_position() -> void:
	pass
	"""
	var sequence: Array[Globals.movement] = player.input_sequence
	var i: int  = movecount%len(sequence)
	var current_move: Globals.movement = sequence[i]
		
	if (current_move == Globals.movement.UP):
		player.moveUp()
	elif (current_move == Globals.movement.DOWN):
		player.moveDown()
	elif (current_move == Globals.movement.RIGHT):
		player.moveRight()
	elif (current_move == Globals.movement.LEFT):
		player.moveLeft()
	
	
	movecount+=1
	"""
	


	
func check_if_won() -> void:
	pass
