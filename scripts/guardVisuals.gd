extends Node3D

@export var input_sequence: Array[Globals.movement] = []
@export var AnimPlayer: AnimationPlayer
@export var HopAnimator: Node3D
@export var RotationAnimator: Node3D

func _onready():
	AnimPlayer.play("RESET")

@onready var time = 0
@onready var rot_time = 0
@onready var next_rotation = RotationAnimator.rotation
@onready var prev_rotation = RotationAnimator.rotation
@onready var next_position = global_position
@onready var prev_position = global_position

@onready var prev := "up"


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
	AnimPlayer.play("hop")
	time = 0.0
	prev_position = next_position
	next_position = global_position + direction
	
func _rotateVisually(rot: Vector3) -> void:
	rot_time = 0.0
	prev_rotation = next_rotation
	next_rotation += rot
	
func _process(delta):
	time += delta * 1
	time = clamp(time, 0.0, 1.0)
	global_position = prev_position.lerp(next_position,time)
	
	rot_time += delta * 1
	rot_time = clamp(rot_time, 0.0, 1.0)
	RotationAnimator.rotation = prev_rotation.lerp(next_rotation,rot_time)
