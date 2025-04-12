extends Control

signal heist_planned(sequence) # signal when done
signal add_movement(move: Globals.movement, pos: Vector2i)
signal remove_last_movement(pos: Vector2i)

var input_sequence: Array[Globals.movement] = []

var valid_pos: Array[Vector2i] = Globals.valid_pos.duplicate(true)
var starting_pos: Vector2i = Globals.starting_pos
var current_pos: Vector2i = starting_pos
var move_history: Array[Vector2i] = [starting_pos]

@onready
var sequence_display_label: Label = $VBoxContainer/Sequence
@onready
var instructions_label: Label = $VBoxContainer/InstructionLabel
@onready
var error_label: Label = $VBoxContainer/NEIN

#-----------------------------------------------------------------------

func _ready() -> void:
	# Update display in case we load the last sequence till failure, to avoid needing to start over again. 
	update_display(true)

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
			update_display(false)
			pass
			
		
func add_action(action: Globals.movement) -> void:
	input_sequence.append(action)
	emit_signal("add_movement", action, current_pos) 
	update_display(true)

func remove_last_action() -> void:
	if not input_sequence.is_empty():
		move_history.pop_back()
		
		current_pos = move_history.get(len(move_history)-1)
		emit_signal("remove_last_movement", current_pos)
		input_sequence.pop_back() 
		update_display(true)

func update_display(valid: bool) -> void:
	if input_sequence.is_empty():
		sequence_display_label.text = "[Empty Sequence]"
	else:
		sequence_display_label.text = " -> ".join(input_sequence)
	
	if valid:
		error_label.text = ":)"
	else: 
		error_label.text = "Bist du dumm?"
		# TODO signal the user, shaking label

func finalize_sequence() -> void:
	if input_sequence.is_empty():
		print("Cannot finalize an empty sequence.")
		update_display(false)
		return

	print("Sequence finalized: ", input_sequence)
	emit_signal("heist_planned", input_sequence)

func clear_sequence() -> void:
	input_sequence.clear()
	update_display(true)

func load_sequence(sequence: Array) -> void:
	input_sequence = sequence.duplicate() 
	update_display(true)

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
	if new_position in valid_pos or true:
		current_pos = new_position
		move_history.append(new_position)
		return true
	
	return false
