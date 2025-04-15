extends Node

signal lost()
signal won()
signal request_data()

@export var player: Node3D
@export var goal: Node3D
@export var lose:Control
@export var win:Control

@export var win_jingle: AudioStreamPlayer
@export var lose_jingle: AudioStreamPlayer
@export var music: AudioStreamPlayer

var game_over: bool = false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	Globals.player_spotted = false
	Globals.time_between_moves = 1.2
		
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
		
		
func _input(event: InputEvent) -> void:
	
	if get_tree().current_scene.name == Globals.game_scene_name and not game_over:
		if event.is_action("Speedup") and event is InputEventKey:
			if event.pressed and Globals.allow_speedup:
				Globals.time_between_moves = 0.3
				Globals.speed = 4.8
			else:
				Globals.time_between_moves = 1.2
				Globals.speed = 1.2

func check_win():
	if goal.transform.origin.distance_to(player.transform.origin) <= 3 and not game_over:
		print("You won.")
		game_over = true
		Globals.previous_sequence = [] 
		Globals.previous_move_count = 0
		win.show()
		music.stop()
		win_jingle.play()
		emit_signal("won")
		return true
	return false

func check_lose():
	if Globals.dev_mode:
		return
		
	if Globals.player_spotted and not game_over:
		print("Game over")
		game_over = true
		Globals.time_between_moves *= 100
		lose.show()
		music.stop()
		lose_jingle.play()

func _on_player_movement_controller_out_of_moves() -> void:
	if not game_over:
		game_over = true
		Globals.time_between_moves *= 100
		lose.show()
		music.stop()
		lose_jingle.play()
	#post_lose_precedure()
	
func post_lose_precedure():
	lose.hide()
	Globals.time_between_moves = 1.2
	print("run again")
	print(Globals.time_between_moves)
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
