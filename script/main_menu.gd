extends Node

var game_loop: PackedScene = preload("res://scene/game_loop.tscn")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(game_loop)

func _on_quit_pressed() -> void:
	get_tree().quit()
