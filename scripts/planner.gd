extends Control

signal heist_planned(sequence) # signal when done
signal add_movement(move: Globals.movement, pos: Vector2i)
signal remove_last_movement(pos: Vector2i)
signal place_skull(pos: Vector2i)

@export var player: Node3D

@onready var invalid_sound: AudioStreamPlayer = $InvalidSound

var input_sequence: Array[Globals.movement] = []

var valid_pos: Array[Vector2i] = Globals.valid_pos.duplicate(true)
var current_pos: Vector2i #= starting_pos
var move_history: Array[Vector2i]# = [starting_pos]


var starting_pos: Vector2i # = calculate_pos_vector_from_global_pos()

var init_done: bool = false
#-----------------------------------------------------------------------

func _on_player_ready() -> void:
	pass

func _ready() -> void:
	if not player:
		push_error("Player node missing even after defer!")
		return
		
	starting_pos = calculate_pos_vector_from_global_pos()
	current_pos = starting_pos
	move_history = [starting_pos]
	



func _process(delta: float) -> void:
	if not init_done and Globals.previous_sequence != [] and Globals.previous_move_count != 0:
		load_sequence()
		init_done = true
	elif not init_done:
		init_done = true



func _input(event: InputEvent) -> void:
	if not event.is_pressed():
		return

	var move: Globals.movement = Globals.movement.NULL
	
	if event.is_action("PlannerUp", true):
		move = Globals.movement.UP
	elif event.is_action("PlannerDown", true):
		move = Globals.movement.DOWN
	elif event.is_action("PlannerLeft", true):
		move = Globals.movement.LEFT
	elif event.is_action("PlannerRight", true):
		move = Globals.movement.RIGHT
	elif event.is_action("PlannerHide", true):
		move = Globals.movement.HIDE
	elif event.is_action("PlannerDelete", true):
		remove_last_action()
	elif event.is_action("PlannerCommit", true):
		finalize_sequence()

	if move != Globals.movement.NULL:
		if (check_move(move)):
			add_action(move)
		else:
			# TODO: Signal user invalid move by shaking screen
			invalid_sound.play()
			pass
			
		
func add_action(action: Globals.movement) -> void:
	input_sequence.append(action)
	emit_signal("add_movement", action, current_pos) 

func remove_last_action() -> void:
	if not input_sequence.is_empty():
		move_history.pop_back()
		
		current_pos = move_history.get(len(move_history)-1)
		emit_signal("remove_last_movement", current_pos)
		input_sequence.pop_back() 
		print(input_sequence)

func finalize_sequence() -> void:
	if input_sequence.is_empty():
		print("Cannot finalize an empty sequence.")
		return

	print("Sequence finalized: ", input_sequence)
	emit_signal("heist_planned", input_sequence)

func clear_sequence() -> void:
	input_sequence.clear()
	

func check_move(move: Globals.movement) -> bool:
	var new_position = current_pos
	
	if (move == Globals.movement.HIDE):
		pass
	elif (move == Globals.movement.UP):
		new_position[0] += 1
	elif (move == Globals.movement.DOWN):
		new_position[0] -= 1
	elif (move == Globals.movement.RIGHT):
		new_position[1] += 1
	elif (move == Globals.movement.LEFT):
		new_position[1] -= 1
	else:
		push_error("MICHI is fett am cheaten")
		
	# TODO remove or true
	if new_position in valid_pos or Globals.dev_mode:
		current_pos = new_position
		move_history.append(new_position)
		return true
	
	return false


func calculate_pos_vector_from_global_pos() -> Vector2i:
	var position: Vector2i = Vector2i(0, 0)
	position.y = player.transform.origin.x
	position.x = -player.transform.origin.z
	#print(player.transform.origin)
	#print(position)
	return position


func load_sequence() -> void:
	var old_input_sequence = Globals.previous_sequence.duplicate(true)
	#print(old_input_sequence)
	#print(Globals.previous_move_count)
	
	for i in range(Globals.previous_move_count-1):
		if (check_move(old_input_sequence[i])):
			add_action(old_input_sequence[i])
	
	emit_signal("place_skull", current_pos)
		
	
	print("hmm")
