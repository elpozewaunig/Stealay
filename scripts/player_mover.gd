extends Node

@export var player: Node3D
var input_sequence: Array[Globals.movement]

var delay: float = Globals.time_between_moves
var time_passed: float = 0.0

var movecount: int = 0


func _ready() -> void:
	input_sequence = Globals.player_sequence
	
	if input_sequence.is_empty():
		push_error("Michi")
	
func _process(delta: float) -> void:
	if time_passed >= delay:
		time_passed = 0.0
		move()
	
	time_passed += delta


func move() -> void: 
	change_position()
	check_if_won()


func change_position() -> void:
	var sequence: Array[Globals.movement] = input_sequence
	if (movecount >= sequence.size()):
		return # TODO: Failed
	
	var current_move: Globals.movement = sequence[movecount]
		
	if (current_move == Globals.movement.UP):
		player.moveUp()
	elif (current_move == Globals.movement.DOWN):
		player.moveDown()
	elif (current_move == Globals.movement.RIGHT):
		player.moveRight()
	elif (current_move == Globals.movement.LEFT):
		player.moveLeft()
	
	
	movecount+=1
	


	
func check_if_won() -> void:
	pass
