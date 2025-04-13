extends Node

signal lost()
signal won()
signal request_data()

@export var player: Node3D
@export var goal: Node3D

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	Globals.player_spotted = false
		
func _process(_delta):
	if Input.is_action_just_pressed("Escape"):
		$"../PauseMenu".visible = not $"../PauseMenu".visible
		if get_tree().current_scene.name != Globals.game_scene_name:
			$"../TuringBandlUI".visible = not $"../TuringBandlUI".visible
		get_tree().paused = not get_tree().paused
		$"../PauseMenu".resetUI()
		
	if get_tree().current_scene.name == Globals.game_scene_name:
		if not check_win():
			check_lose()
		
		

func check_win():
	if goal.transform.origin.distance_to(player.transform.origin) <= 3:
		print("You won.")
		emit_signal("won")
		return true
	return false

func check_lose():
	if Globals.dev_mode:
		return
		
	if Globals.player_spotted :
		print("Game over")
		post_lose_precedure()

func _on_player_movement_controller_out_of_moves() -> void:
	if Globals.dev_mode:
		return
	post_lose_precedure()
	
func post_lose_precedure():
	emit_signal("lost")
	emit_signal("request_data")


func _on_player_movement_controller_send_data(movecount: int, input_sequence: Array) -> void:
	Globals.previous_move_count = movecount
	Globals.previous_sequence = input_sequence
	scene_loader("res://scenes/PlanningScene.tscn")

	
func scene_loader(scene_location: String):
	get_tree().change_scene_to_file(scene_location)


func _on_planning_scene_load_game_board(location: Variant) -> void:
	scene_loader(location)
