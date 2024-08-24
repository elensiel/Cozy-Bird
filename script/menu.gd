extends Node2D

signal music_toggle_on
signal music_toggle_off

@onready var audio = $AudioStreamPlayer2D
@onready var game_manager = $"Game Manager"
@onready var high_score = $"UI/High Score"
@onready var ui = $UI

func _ready() -> void:
	high_score.text = str("HIGH SCORE: ", game_manager.high_score)

func _on_play_pressed() -> void:
	audio.play()
	await audio.finished
	get_tree().change_scene_to_file("res://scene/main.tscn")

func _on_quit_pressed() -> void:
	audio.play()
	await audio.finished
	get_tree().quit()

## Turn Music ON/OFF
func _on_music_toggle_toggled(toggled_on) -> void:
	audio.play()
	
	if toggled_on:
		music_toggle_on.emit()
	else:
		music_toggle_off.emit()
