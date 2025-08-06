extends Node

const PITCH_INCREASE_FACTOR: float = 0.005
var FILE_PATH: String = _ensure_directory() + "score.dat"

var current_score_label : Label
var high_score_label : Label

var high_score: int = _load_score()
var current_score: int = 0

func _init() -> void:
	print("ScoreManager: Setting up")

func _ensure_directory() -> String:
	var directory: String = OS.get_user_data_dir()
	if !DirAccess.dir_exists_absolute(directory):
		DirAccess.make_dir_absolute(directory)
	return directory

func _save_score() -> void:
	var file: FileAccess = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_16(high_score)
		return file.close()
	
	var error: Error = FileAccess.get_open_error()
	printerr("Saving state error: " + error_string(error))

func _load_score() -> int:
	var file: FileAccess = FileAccess.open(FILE_PATH, FileAccess.READ)
	if file: 
		return file.get_16()
	
	var error: Error = FileAccess.get_open_error()
	printerr("Loading state error: " + error_string(error))
	return 0

func increase_score() -> void:
	current_score += 1
	current_score_label.text = str(current_score)
	
	# elevate the streak feel
	AudioManager.score.pitch_scale += PITCH_INCREASE_FACTOR
	AudioManager.score.play()

func check_score() -> void:
	if current_score <= high_score: return
	
	high_score = current_score
	_save_score()
	current_score_label.text = "\n" + current_score_label.text + "\nNEW HIGH SCORE!"
