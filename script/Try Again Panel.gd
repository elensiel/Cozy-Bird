extends CanvasLayer

@onready var audio = $AudioStreamPlayer2D
@onready var high_score = $"High Score"
@onready var score = $Score
@onready var game_manager = get_parent().find_child("Game Manager")

func _ready():
	score.text = str(game_manager.score)
	
	if game_manager.high_scored:
		high_score.visible = true

func _on_restart_pressed():
	audio.play()
	await audio.finished
	get_tree().reload_current_scene()
	queue_free()

func _on_back_pressed():
	audio.play()
	await audio.finished
	get_tree().change_scene_to_file("res://scene/menu.tscn")
