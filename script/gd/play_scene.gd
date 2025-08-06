extends Node

func _init() -> void:
	print("PlayScene: Setting up")

func _ready() -> void:
	StateMachine.change_state(StateMachine.State.NEW)
