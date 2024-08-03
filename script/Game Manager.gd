extends Node2D

@onready var ui = $"../UI"

const SAVE_PATH = "user://score.json"
var score : int = 0
var high_score : int = 0
var high_scored : bool = false

func _ready() -> void:
	load_score()
	high_scored = false # to reset

func update_score() -> void:
	score += 1
	ui.update()

func check_high_score() -> void:
	if score > high_score:
		save_score()
		high_scored = true

func save_score() -> void:
	high_score = score
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(high_score)

func load_score() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		high_score = file.get_var()
	else:
		high_score = 0
