extends Node

func _ready() -> void:
	StateMachine.change_state(StateMachine.State.NEW)
