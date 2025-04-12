extends Node3D

signal player_spotted()

var was_colliding_last_frame = {}

func _ready() -> void:
	for child in get_children():
		if child is RayCast3D:
			child.target_position *= Globals.max_sight 
			was_colliding_last_frame[child] = false

func _physics_process(_delta: float) -> void:
	if get_tree().current_scene.name != Globals.game_scene_name:
		return
	for ray: RayCast3D in was_colliding_last_frame.keys():
		var is_colliding_now: bool = ray.is_colliding()

		if is_colliding_now and not was_colliding_last_frame[ray]:
			var object_hit = ray.get_collider()
			if object_hit and object_hit.collision_layer == 1:
				print("RayCast detected hit: ", object_hit.name)
				emit_signal("player_spotted")
				Globals.player_spotted = true
		
		was_colliding_last_frame[ray] = is_colliding_now
