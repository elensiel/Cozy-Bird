extends CanvasLayer

@onready var score_label = $score_label
@onready var starting_label = $starting_label
@onready var game_manager = $"../Game Manager"

func _ready():
	score_label.text = str(game_manager.score)

func update() -> void:
	score_label.text = str(game_manager.score)

func visibility(value : bool) -> void:
	starting_label.visible = value
