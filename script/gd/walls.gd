extends Node

func _init() -> void:
	ObjectReferences.walls = self

func _ready() -> void:
	for area in get_children():
		area.connect(&"body_entered", Callable.create(self, &"_on_wall_body_entered"))

func _on_wall_body_entered(crow: Crow) -> void:
	if StateMachine.current_state != StateMachine.State.DYING:
		StateMachine.call_deferred("change_state", StateMachine.State.DYING)
		crow.physics.Flap()
