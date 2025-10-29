extends Control
class_name MainMenu

const PLAY_SCENE_PATH: String = "res://scene/play_scene.tscn"

func _init() -> void:
	print("MainMenu: Setting up")

func _ready() -> void:
	AudioManager.play_ambience(AudioManager.Ambience.HARBOR)

func _on_play_pressed() -> void:
	AudioManager.play_button_press()
	get_tree().change_scene_to_file(PLAY_SCENE_PATH)

func _on_quit_pressed() -> void:
	AudioManager.play_button_press()
	get_tree().quit()
