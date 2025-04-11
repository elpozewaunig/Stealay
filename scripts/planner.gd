extends Control

signal heist_planned(sequence) # signal when done

var input_sequence: Array[Globals.movement] = []
var game_scene: String = ""

@onready
var sequence_display_label: Label = $VBoxContainer/Sequence
@onready
var instructions_label: Label = $VBoxContainer/InstructionLabel

#-----------------------------------------------------------------------

func _ready() -> void:
	# Update display in case we load the last sequence till failure, to avoid needing to start over again. 
	update_display()

func _input(event: InputEvent) -> void:
	if not event.is_pressed():
		return

	if event.is_action("PlannerUp", true):
		add_action(Globals.movement.UP)
	elif event.is_action("PlannerDown", true):
		add_action(Globals.movement.DOWN)
	elif event.is_action("PlannerLeft", true):
		add_action(Globals.movement.LEFT)
	elif event.is_action("PlannerRight", true):
		add_action(Globals.movement.RIGHT)
	elif event.is_action("PlannerHide", true):
		add_action(Globals.movement.HIDE)
	elif event.is_action("PlannerDelete", true):
		remove_last_action()
	elif event.is_action("PlannerCommit", true):
		finalize_sequence()

func add_action(action_string: Globals.movement) -> void:
	input_sequence.append(action_string)
	update_display()

func remove_last_action() -> void:
	if not input_sequence.is_empty():
		input_sequence.pop_back() 
		update_display()

func update_display() -> void:
	if input_sequence.is_empty():
		sequence_display_label.text = "[Empty Sequence]"
	else:
		sequence_display_label.text = " -> ".join(input_sequence)

func finalize_sequence() -> void:
	if input_sequence.is_empty():
		print("Cannot finalize an empty sequence.")
		# TODO signal the user, shaking label
		return

	print("Sequence finalized: ", input_sequence)
	emit_signal("heist_planned", input_sequence)

func clear_sequence() -> void:
	input_sequence.clear()
	update_display()

func load_sequence(sequence: Array) -> void:
	input_sequence = sequence.duplicate() 
	update_display()
