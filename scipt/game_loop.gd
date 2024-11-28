extends Node

enum STATES { PAUSE, RUNNING, DEAD }
var state : STATES


func _ready() -> void:
	state = STATES.PAUSE
