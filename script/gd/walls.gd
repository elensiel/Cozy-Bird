extends Node

func _init() -> void:
	ObjectReferences.walls = self

func _ready() -> void:
	for area in get_children():
		area.connect(&"body_entered", Callable.create(self, &"_on_wall_body_entered"))

func _on_wall_body_entered(crow: Crow) -> void:
	if ObjectReferences.state_machine.current_state != StateMachine.State.DYING:
		ObjectReferences.state_machine.call_deferred("change_state", StateMachine.State.DYING)
		crow.physics.Flap()
