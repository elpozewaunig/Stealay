extends Node3D

signal load_game_board(location)

func _ready() -> void:
	start_planning_phase()

func _on_heist_planner_heist_planned(sequence: Variant) -> void:
	$HeistPlanner.hide()
	print("Main script received sequence: ", sequence)
	Globals.player_sequence = sequence.duplicate(true)
	start_game()


func start_planning_phase():
	$HeistPlanner.clear_sequence() 
	$HeistPlanner.show() 


func start_game():
	if Globals.player_sequence.is_empty():
		print("No sequence planned!")
		return

	print("Start game: ", Globals.player_sequence)
	Globals.player_spotted = false
	emit_signal("load_game_board", SceneManager.game_scene)
	
	
