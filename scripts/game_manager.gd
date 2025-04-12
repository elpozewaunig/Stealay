extends Node

@export var player: Node3D

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	Globals.player_spotted = false
		
func _process(_delta):
	if Input.is_action_just_pressed("Escape"):
		$"../PauseMenu".visible = not $"../PauseMenu".visible
		$"../TuringBandlUI".visible = not $"../TuringBandlUI".visible
		get_tree().paused = not get_tree().paused
		$"../PauseMenu".resetUI()
		
	if Globals.player_spotted and get_tree().current_scene.name == Globals.game_scene_name:
		print("Game over")
		

func check_win():
	pass
