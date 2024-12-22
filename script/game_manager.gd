extends Node
class_name GameManager

@onready var label: Label = $Label
@onready var try: Node = preload("res://scene/retry_panel.tscn").instantiate()

static var score: int = 0
static var high_score: int = load_score()

func _ready() -> void:
	score = 0

func inc_score() -> void:
	score += 1
	label.text = str(score)

static func _ensure_directory_exists() -> String:
	var directory: String = OS.get_user_data_dir() + "/save/"
	if !DirAccess.dir_exists_absolute(directory):
		DirAccess.make_dir_absolute(directory)
	return directory

static func _open_file(mode_flag: FileAccess.ModeFlags) -> FileAccess:
	var save_path: String = _ensure_directory_exists() + "save.bin"
	return FileAccess.open(save_path, mode_flag)

static func load_score() -> int:
	var file: FileAccess = _open_file(FileAccess.ModeFlags.READ)
	
	if file == null:
		file = _open_file(FileAccess.ModeFlags.WRITE)
		file.store_16(0)
		file.close()
		return 0
	return file.get_16()

static func save_high_score() -> void:
	if high_score < score:
		var file := _open_file(FileAccess.ModeFlags.WRITE)
		if file:
			file.store_16(high_score)
			file.close()
		else:
			print("Error: Could not open file for writing.")

func _on_death_timer_timeout() -> void:
	add_child(try)
	
	label.visible = false
