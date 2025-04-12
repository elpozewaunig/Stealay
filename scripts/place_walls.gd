extends Node3D


var wall_element_scene: PackedScene = preload("res://assets/Wall.tscn")

func _init() -> void:
	for position: Vector2i in Globals.invalid_pos:
		var pos = Globals.calculate_global_position_from_pos(position)
		var new_wall_element = wall_element_scene.instantiate()
		new_wall_element.position = pos
		add_child(new_wall_element, false)
		
