extends Node

func _init() -> void:
	print("PlayScene: Setting up")

func _ready() -> void:
	ObjectReferences.state_machine.change_state(StateMachine.State.NEW)
	AudioManager.play_ambience(AudioManager.Ambience.DOWNTOWN)
