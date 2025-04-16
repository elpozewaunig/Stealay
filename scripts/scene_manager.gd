extends Node

@export var menu_scene: PackedScene
@export var planning_scene: PackedScene
@export var game_scene: PackedScene
@export var loading_scene: PackedScene

var target_scene: PackedScene

func change_scene(scene: PackedScene) -> void:
	target_scene = scene
	
	var current_scene = get_tree().current_scene
	var loading_scene = loading_scene.instantiate()
	
	# Adding scene and removing previous one rather than
	# changing immediately prevents brief screen flicker
	get_tree().root.add_child(loading_scene)
	get_tree().current_scene = loading_scene
	current_scene.queue_free()
	
