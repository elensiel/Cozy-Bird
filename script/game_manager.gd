extends Node
class_name GameManager

@onready var label: Label = $Label

var score: int = 0

func _ready() -> void:
	label.text = str(score)

func inc_score() -> void:
	score += 1
	_ready()
