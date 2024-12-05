extends Node

var game_loop: PackedScene = preload("res://scene/game_loop.tscn")
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	$Label.text = "HIGH SCORE: " + str(_load_score())

func _load_score() -> int:
	var DIR: String = OS.get_user_data_dir() + "/save/"
	
	if not DirAccess.dir_exists_absolute(DIR):
		# creates directory
		DirAccess.make_dir_absolute(DIR)
		
		# creates save file and store 0 to prevent null error
		FileAccess.open(DIR + "score.bin", FileAccess.WRITE).store_16(0)
		return 0
	
	return FileAccess.open(DIR + "score.bin", FileAccess.READ).get_16()

func _on_play_pressed() -> void:
	audio.play()
	await audio.finished
	get_tree().change_scene_to_packed(game_loop)

func _on_quit_pressed() -> void:
	audio.play()
	await audio.finished
	get_tree().quit()
