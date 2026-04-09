extends Button

func _on_pressed() -> void:
	AudioManager.play_sfx(AudioManager.Sfx.BUTTON_PRESS)
