extends Control

var scene_path := 'res://scene/main_menu.tscn'
var scene_load_status := 0
var progress := []

func _ready() -> void:
	ResourceLoader.load_threaded_request(scene_path)

func _process(_delta: float) -> void:
	scene_load_status = ResourceLoader.load_threaded_get_status(scene_path, progress)
	$CenterContainer/Label.text = str(floorf(progress[0] * 100)) + '%'
	if scene_load_status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene_path))
