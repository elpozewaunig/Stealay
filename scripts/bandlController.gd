extends VBoxContainer


@export var bandl1:Control
@export var bandl2:Control 
@export var bandl3:Control 
@export var bandl4:Control


var movements:Array
enum movement { 
	UP,
	DOWN,
	RIGHT, 
	LEFT, 
	HIDE,
	NONE
	}
var done = true

func _process(_delta):
	if(!done):
		insert_new_movement(movement.UP,self)
		insert_new_movement(movement.DOWN,self)
		insert_new_movement(movement.RIGHT,self)
		insert_new_movement(movement.RIGHT,self)
		insert_new_movement(movement.LEFT,self)
		delete_movement(self)
		done = true
func insert_new_movement(sel:movement,empty)-> void:
	var tempVi = bandl4.movementPos
	bandl4.change_visibility(sel,empty)
	var tempVi2 = bandl3.movementPos
	bandl3.change_visibility(tempVi,empty)
	tempVi = bandl2.movementPos
	bandl2.change_visibility(tempVi2,empty)
	movements.append(bandl1.movementPos)
	bandl1.change_visibility(tempVi,empty)
	
func delete_movement(empty)->void: 
	bandl4.change_visibility(bandl3.movementPos,empty)
	bandl3.change_visibility(bandl2.movementPos,empty)
	bandl2.change_visibility(bandl1.movementPos,empty)
	bandl1.change_visibility(movements.get(movements.size()-1),empty)
	movements.remove_at(movements.size()-1)
	
