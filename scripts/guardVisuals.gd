extends Node3D

@export var input_sequence: Array[Globals.movement] = []
@export var on_patrol: bool = true
@export var play_hop_sound: bool = false
@export var hop_sound: AudioStreamPlayer
@export var AnimPlayer: AnimationPlayer
@export var HopAnimator: Node3D
@export var RotationAnimator: Node3D
@export var id:int

func _onready():
	AnimPlayer.play("RESET")
		


@onready var time = 0
@onready var rot_time = 0
@onready var next_rotation = RotationAnimator.rotation
@onready var prev_rotation = RotationAnimator.rotation
@onready var next_position = global_position
@onready var prev_position = global_position

@onready var prev := "up"
@export var token:Sprite3D
@export var alert:Label3D

func _ready() -> void:

	if id !=10 && id != 0:
		if Globals.guard == id: 
			alert.show()
		else: 
			alert.hide()
	next_position = global_position
	prev_position = global_position
	#print("Instanciating guard somewhere ")
	print(get_tree().current_scene.name)
	if get_tree().current_scene.name =="PlanningScene": 
		token.show()
	elif get_tree().current_scene.name =="Game":
		token.hide()
	if get_tree().current_scene.name != Globals.game_scene_name:
		Globals.speed = 10
	else: 
		Globals.speed = 1.2

func moveUp() -> void:
	_move(Vector3(0,0,-1))
	
	if prev == "down":
		_rotateVisually(Vector3(0,deg_to_rad(180*pow(-1, randi() % 2)),0))
	elif prev == "left":
		_rotateVisually(Vector3(0,deg_to_rad(-90),0))
	elif prev == "right":
		_rotateVisually(Vector3(0,deg_to_rad(90),0))
	prev = "up"
	
func moveDown() -> void:
	_move(Vector3(0,0,1))
	if prev == "up":
		_rotateVisually(Vector3(0,deg_to_rad(180*pow(-1, randi() % 2)),0))
	
	elif prev == "left":
		_rotateVisually(Vector3(0,deg_to_rad(90),0))
	elif prev == "right":
		_rotateVisually(Vector3(0,deg_to_rad(-90),0))
	prev = "down"
	
func moveLeft() -> void:
	_move(Vector3(-1,0,0))
	if prev == "up":
		_rotateVisually(Vector3(0,deg_to_rad(90),0))
	elif prev == "down":
		_rotateVisually(Vector3(0,deg_to_rad(-90),0))
	elif prev == "right":
		_rotateVisually(Vector3(0,deg_to_rad(180*pow(-1, randi() % 2)),0))
		
	prev = "left"
	
func moveRight() -> void:
	_move(Vector3(1,0,0))
	if prev == "up":
		_rotateVisually(Vector3(0,deg_to_rad(-90),0))
	elif prev == "down":
		_rotateVisually(Vector3(0,deg_to_rad(90),0))
	elif prev == "left":
		_rotateVisually(Vector3(0,deg_to_rad(180*pow(-1, randi() % 2)),0))

	prev = "right"
	
func _move(direction: Vector3) -> void:
	if get_tree().current_scene.name == Globals.game_scene_name:
		AnimPlayer.play("hop")
		
	time = 0.0
	prev_position = next_position
	global_position = prev_position
	next_position = global_position + direction
	if play_hop_sound:
		hop_sound.play()
	
func _rotateVisually(rot: Vector3) -> void:
	rot_time = 0.0
	prev_rotation = next_rotation
	next_rotation += rot
	
func _process(delta):
	time += delta * Globals.speed
	time = clamp(time, 0.0, 1.0)
	global_position = prev_position.lerp(next_position,time)
	
	rot_time += delta * Globals.speed
	rot_time = clamp(rot_time, 0.0, 1.0)
	RotationAnimator.rotation = prev_rotation.lerp(next_rotation,rot_time)
