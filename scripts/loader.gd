extends Control

var scene_path: String = SceneManager.target_scene.resource_path

func _ready() -> void:
	ResourceLoader.load_threaded_request(scene_path)
	
func _process(delta: float) -> void:
	var scene_load_status = ResourceLoader.load_threaded_get_status(scene_path, [])
	
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var scene = ResourceLoader.load_threaded_get(scene_path)
		get_tree().change_scene_to_packed(scene)
