extends Node

func _ready() -> void:
	for area in get_children():
		area.connect(&"body_entered", Callable.create(self, &"_on_wall_body_entered"))

func _on_wall_body_entered(body: Crow) -> void:
	body.physics.Flap()
	StateMachine.change_state(StateMachine.State.DEAD)
