extends Area2D

func _physics_process(delta: float) -> void:
	if owner.current_state == GameStateMachine.GameState.RUNNING:
		position.x -= 100 * delta

## TODO -- kill and score
func _kill(body: CharacterBody2D) -> void:
	pass
