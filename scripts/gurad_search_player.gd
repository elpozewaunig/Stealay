extends RayCast3D

signal player_spotted()

var was_colliding_last_frame: bool = false


func _physics_process(delta: float) -> void:
	var is_colliding_now: bool = is_colliding()

	if is_colliding_now and not was_colliding_last_frame:
		var object_hit = get_collider()
			
		if object_hit: 
			print("RayCast detected hit: ", object_hit.name)
			player_spotted.emit()


	was_colliding_last_frame = is_colliding_now
