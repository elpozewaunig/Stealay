extends Control

@export var manager:VBoxContainer

@onready
var turingBandl: VBoxContainer = $Panel/VBoxContainer

enum movement { 
	UP,
	DOWN,
	RIGHT, 
	LEFT, 
	HIDE, 
	NONE
	}
	
func _on_heist_planner_add_movement(move: Globals.movement) -> void:
	turingBandl.insert_new_movement(move, self)

func _on_heist_planner_remove_last_movement() -> void:
	turingBandl.delete_movement(self)
