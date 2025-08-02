extends Control
class_name MainMenu

func _on_play_pressed() -> void:
	AudioManager.button_press.play()

func _on_quit_pressed() -> void:
	AudioManager.button_press.play()
	await AudioManager.button_press.finished
	
	get_tree().quit()
