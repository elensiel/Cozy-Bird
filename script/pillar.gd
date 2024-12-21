extends Area2D

@onready var main := get_parent().get_parent() as GameStateMachine
@onready var gm := main.get_node("GameManager") as GameManager
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _physics_process(delta: float) -> void:
	if main.current_state == GameStateMachine.GameState.RUNNING:
		position.x -= 125 * delta

## KILL
func _on_kill_body_entered(_body: Node2D) -> void:
	main.set_state(GameStateMachine.GameState.DEAD)

## SCORE
func _on_body_entered(_body: Node2D) -> void:
	if main.current_state == GameStateMachine.GameState.RUNNING:
		gm.inc_score()
		audio.play()
