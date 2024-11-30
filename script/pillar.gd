extends Area2D

@onready var main := get_parent().get_parent() as GameStateMachine

func _physics_process(delta: float) -> void:
	if main.current_state == GameStateMachine.GameState.RUNNING:
		position.x -= 100 * delta

## KILL
func _on_kill_body_entered(body: Node2D) -> void:
	main.set_state(GameStateMachine.GameState.DEAD)

## SCORE
func _on_body_exited(body: Node2D) -> void:
	pass
