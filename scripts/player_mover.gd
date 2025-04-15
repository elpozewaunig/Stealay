extends Node

signal out_of_moves()
signal send_data(movecount: int, input_sequence: Array[Globals.movement])

@export var player: Node3D
var input_sequence: Array[Globals.movement]


var time_passed: float = 0.0

var movecount: int = 0


func _ready() -> void:
	input_sequence = Globals.player_sequence
	Globals.hide_active = false
	
	if Globals.max_speedup_turns > 0:
		Globals.allow_speedup = true
	else:
		Globals.allow_speedup = false
	
	if input_sequence.is_empty():
		push_error("Michi")
	
func _process(delta: float) -> void:
	if time_passed >= Globals.time_between_moves:
		time_passed = 0.0
		change_position()
	
	time_passed += delta
	


func change_position() -> void:
	var sequence: Array[Globals.movement] = input_sequence
	if (movecount >= sequence.size()):
		emit_signal("out_of_moves")
		return
	
	if (Globals.hide_active):
		Globals.hide_active = false
		
		
	
	var current_move: Globals.movement = sequence[movecount]
	
	if movecount < Globals.max_speedup_turns:
		Globals.allow_speedup = true
	else:
		Globals.allow_speedup = false
		
	if (current_move == Globals.movement.UP):
		player.moveUp()
	elif (current_move == Globals.movement.DOWN):
		player.moveDown()
	elif (current_move == Globals.movement.RIGHT):
		player.moveRight()
	elif (current_move == Globals.movement.LEFT):
		player.moveLeft()
	elif (current_move == Globals.movement.HIDE):
		Globals.hide_active = true
		
	
	
	movecount+=1
	


func _on_game_manager_request_data() -> void:
	emit_signal("send_data", movecount, input_sequence)
