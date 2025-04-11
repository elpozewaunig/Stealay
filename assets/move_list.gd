extends Node

var starting_position: Vector2i = Vector2i(Transform3D.)

var input_sequence: Array[Globals.movement] = [
	Globals.movement.UP, Globals.movement.UP, Globals.movement.UP, Globals.movement.UP,
	Globals.movement.UP, 
	Globals.movement.RIGHT, Globals.movement.RIGHT, Globals.movement.RIGHT,
	Globals.movement.DOWN, Globals.movement.DOWN, Globals.movement.DOWN, Globals.movement.DOWN,
	Globals.movement.DOWN, 
	Globals.movement.LEFT, Globals.movement.LEFT, Globals.movement.LEFT	
]
