extends Node3D

var planned_heist_sequence: Array = []

func _ready() -> void:
	start_planning_phase()

func _on_heist_planner_heist_planned(sequence: Variant) -> void:
	$HeistPlanner.hide()
	print("Main script received sequence: ", sequence)
	planned_heist_sequence = sequence
	start_execution_phase() 


func start_planning_phase():
	$HeistPlanner.clear_sequence() 
	$HeistPlanner.show() 


func start_execution_phase():
	if planned_heist_sequence.is_empty():
		print("No sequence planned!")
		return

	print("Executing sequence: ", planned_heist_sequence)
