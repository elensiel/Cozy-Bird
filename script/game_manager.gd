extends Node
class_name GameManager

@onready var label: Label = $Label
@onready var try := preload("res://scene/retry_panel.tscn")

var DIR := "res://save/"
var SAVE_PATH := DIR + "score.bin"
var score: int = 0
var high_score: int = _load_score()

func inc_score() -> void:
	score += 1
	label.text = str(score)

func _load_score() -> int:
	if not DirAccess.dir_exists_absolute(DIR):
		# creates directory
		DirAccess.make_dir_absolute(DIR) 
		
		# creates save file and store 0 to prevent null error
		FileAccess.open(SAVE_PATH, FileAccess.WRITE).store_16(0)
		return 0
	
	return FileAccess.open(SAVE_PATH, FileAccess.READ).get_16()

func save_high_score() -> void:
	if high_score > score: # if score does not beat pr
		return
	
	# storing high score
	high_score = score
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ_WRITE)
	file.store_16(high_score)
	file.close()

func _on_death_timer_timeout() -> void:
	var try_temp := try.instantiate()
	add_child(try_temp)
