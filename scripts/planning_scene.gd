extends Node3D

var planned_heist_sequence: Array = []

func _ready() -> void:
	start_planning_phase()

func _on_heist_planner_heist_planned(sequence: Variant) -> void:
	$HeistPlanner.hide()
	print("Main script received sequence: ", sequence)
	planned_heist_sequence = sequence
	start_game() 


func start_planning_phase():
	$HeistPlanner.clear_sequence() 
	$HeistPlanner.show() 


func start_game():
	if planned_heist_sequence.is_empty():
		print("No sequence planned!")
		return

	print("Start game: ", planned_heist_sequence)
	get_tree().change_scene_to_file("res://scenes/GameScene.tscn")
	
