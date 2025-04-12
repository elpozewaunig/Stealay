extends Node

@export var player: Node3D
@export var goal: Node3D

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	Globals.player_spotted = false
		
func _process(_delta):
	if Input.is_action_just_pressed("Escape"):
		$"../PauseMenu".visible = not $"../PauseMenu".visible
		$"../TuringBandlUI".visible = not $"../TuringBandlUI".visible
		get_tree().paused = not get_tree().paused
		$"../PauseMenu".resetUI()
		
	if get_tree().current_scene.name == Globals.game_scene_name:
		check_lose()
		check_win()
		

func check_win():
	if goal.transform.origin.distance_to(player.transform.origin) < 1.5:
		print("You won.")

func check_lose():
	if Globals.player_spotted :
		#print("Game over")
		pass
	
