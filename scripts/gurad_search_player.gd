extends Node3D

signal player_spotted()

@export var spotted_sound: AudioStreamPlayer

@export var cone_color: Color 
var id:int

var was_colliding_last_frame = {} 
var raycasts: Array[RayCast3D] = [] 
var original_side_ray_targets = {}

# Stupid MeshStuff
var mesh_instance: MeshInstance3D
var vision_cone_mesh: ArrayMesh
var vision_cone_material: StandardMaterial3D


func _ready() -> void:
	# --- setup raycast ---

	id = get_parent().get_parent().id
	
		
	var unsorted_rays: Array[RayCast3D] = []
	for child in get_children():
		if child is RayCast3D:
			# scale, set active, add
			child.target_position = child.target_position * Globals.max_sight
			was_colliding_last_frame[child] = false
			unsorted_rays.append(child)
			if child.is_in_group("side_ray_cast_shit"):
				original_side_ray_targets[child] = child.target_position

	
	# lambda sorting function to sort raycasts according to rotation
	unsorted_rays.sort_custom(func(a: RayCast3D, b: RayCast3D):
		return a.rotation.y < b.rotation.y
	)
	
	# sort 
	raycasts = unsorted_rays
	

	# --- setup mesh ---
	mesh_instance = MeshInstance3D.new() # der Knoten im Tree
	vision_cone_mesh = ArrayMesh.new() # die eigentliche michi magic
	vision_cone_material = StandardMaterial3D.new() # 

	# material
	vision_cone_material.albedo_color = cone_color
	vision_cone_material.transparency = StandardMaterial3D.TRANSPARENCY_ALPHA
	vision_cone_material.cull_mode = StandardMaterial3D.CULL_DISABLED
	vision_cone_material.shading_mode = StandardMaterial3D.SHADING_MODE_UNSHADED

	mesh_instance.mesh = vision_cone_mesh
	mesh_instance.material_override = vision_cone_material 

	add_child(mesh_instance)
	update_vision_cone_mesh()


func _physics_process(_delta: float) -> void:
	# update rays, to create correct cone aaaaaaaaaaaaaaaaaaaaaaaaaaaa
	update_length_of_ray()
	for ray in raycasts:
		ray.force_raycast_update()
	
	update_vision_cone_mesh() 	
	
	if get_tree().current_scene.name == Globals.game_scene_name:
		detect_player() 
	


func detect_player() -> void:
	var player_detected_this_frame: bool = false

	for ray: RayCast3D in raycasts:
		var is_colliding_now: bool = ray.is_colliding()

		if is_colliding_now:
			var object_hit = ray.get_collider()
			if object_hit and object_hit.collision_layer == 1 and not player_detected_this_frame:
				emit_signal("player_spotted")
				if not Globals.player_spotted:
					Globals.guard = id
					print(id)
					spotted_sound.play()
				Globals.player_spotted = true
				player_detected_this_frame = true

		was_colliding_last_frame[ray] = is_colliding_now


func update_vision_cone_mesh() -> void:
	var vertices = PackedVector3Array()
	var indices = PackedInt32Array() # liste wobei der inhalt auf die eckpunkte der Dreiecke verweisen (in vertices liste) -> pointer xd

	vertices.append(Vector3.ZERO) # center of parent node
	var origin_index = 0

	
	for ray in raycasts:
		var endpoint: Vector3
		if ray.is_colliding():
			# when collision, the collision point is global, convert and add
			endpoint = to_local(ray.get_collision_point())
		else:
			# target position is local
			endpoint = ray.transform * ray.target_position
		
		vertices.append(endpoint) # add endpoint to mesh

	
	# triangle party, 1 triangle is center, and two ray endpoints (i, i+1)
	var num_rays = raycasts.size()
	for i in range(num_rays):
		var current_vertex_index = i + 1 # +1, center is [0]
		var next_vertex_index = ((i + 1) % num_rays) + 1 # last to first

		# finally create triangle
		indices.append(origin_index)
		indices.append(current_vertex_index)
		indices.append(next_vertex_index)



	# -- create surface array (points to display) ---
	var surface_array = []
	surface_array.resize(Mesh.ARRAY_MAX)

	surface_array[Mesh.ARRAY_VERTEX] = vertices
	surface_array[Mesh.ARRAY_INDEX] = indices

	# --- lets make michi visible ---
	vision_cone_mesh.clear_surfaces() #clear old
	vision_cone_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface_array)


func update_length_of_ray():
	if Globals.hide_active:
		for ray in raycasts:
			if ray.is_in_group("side_ray_cast_shit"):
				if original_side_ray_targets.has(ray):
					ray.target_position = original_side_ray_targets[ray] * 0.1 # Scale original down
	else:
		for ray in raycasts:
			if ray.is_in_group("side_ray_cast_shit"):
				if original_side_ray_targets.has(ray):
					ray.target_position = original_side_ray_targets[ray] # Restore original
