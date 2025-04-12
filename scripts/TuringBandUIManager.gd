extends Control



var turingBandl: VBoxContainer  


enum movement { 
	UP,
	DOWN,
	RIGHT, 
	LEFT, 
	HIDE, 
	NONE
	}

func _ready() -> void:
	turingBandl = $Panel/VBoxContainer
	
func _on_heist_planner_add_movement(move: Globals.movement, pos: Vector2i) -> void:
	if not is_instance_valid(turingBandl):
		turingBandl = $Panel/VBoxContainer  # Reassign if null
	turingBandl.insert_new_movement(move, self)

func _on_heist_planner_remove_last_movement(pos: Vector2i) -> void:
	turingBandl.delete_movement(self)
