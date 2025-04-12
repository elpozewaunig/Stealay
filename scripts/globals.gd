extends Node


enum movement { 
	UP,
	DOWN,
	RIGHT, 
	LEFT, 
	HIDE, 
	NULL
	}

var starting_pos: Vector2i = Vector2i(0, 0)

var time_between_moves: float = 1.5

var valid_pos: Array[Vector2i] = [
	Vector2i(0, 0), Vector2i(0, 1), Vector2i(0, 2), Vector2i(0, 3), Vector2i(0, 4),
	Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2), Vector2i(1, 3), Vector2i(1, 4),
	Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 2), Vector2i(2, 3), Vector2i(2, 4),
	Vector2i(3, 0), Vector2i(3, 1), Vector2i(3, 2), Vector2i(3, 3), Vector2i(3, 4),
	Vector2i(4, 0), Vector2i(4, 1), Vector2i(4, 2), Vector2i(4, 3), Vector2i(4, 4)
]
