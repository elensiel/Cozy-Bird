extends CanvasLayer

@onready var main = get_parent()
@onready var audio = $AudioStreamPlayer2D

func _on_continue_pressed() -> void:
	audio.play()
	await audio.finished
	get_tree().paused = false
	main.game_run()
	queue_free()

func _on_quit_pressed() -> void:
	audio.play()
	await audio.finished
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/menu.tscn")
