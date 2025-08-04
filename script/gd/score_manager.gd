extends Node

var FILE_PATH: String = _ensure_directory() + "score.dat"

var high_score: int = _load_score()

func _ensure_directory() -> String:
	var directory: String = OS.get_user_data_dir()
	if !DirAccess.dir_exists_absolute(directory):
		DirAccess.make_dir_absolute(directory)
	return directory

func save_score() -> void:
	var file: FileAccess = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_16(high_score)
		file.close()

func _load_score() -> int:
	var file: FileAccess = FileAccess.open(FILE_PATH, FileAccess.READ)
	if file:
		return file.get_var()
	return 0
