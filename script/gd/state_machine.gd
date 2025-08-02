extends Node

enum State {
	NEW,
	RUNNING,
	PAUSED,
	DEAD
}

var current_state: State

func change_state(new_state: State) -> void:
	current_state = new_state
	
	match current_state:
		State.NEW:
			_handle_new()
		State.RUNNING:
			_handle_running()
		State.PAUSED:
			_handle_paused()
		State.DEAD:
			_handle_dead()
	
	_handle_processes()
	_handle_visibility()

func _handle_new() -> void:
	pass

func _handle_running() -> void:
	pass

func _handle_paused() -> void:
	pass

func _handle_dead() -> void:
	pass

func _handle_processes() -> void:
	# Crow processes
	ObjectReferences.crow.physics.set_physics_process(current_state == State.RUNNING)
	ObjectReferences.crow.set_process_unhandled_input(current_state != State.DEAD and current_state != State.PAUSED)
	
	# ParallaxBackground
	ObjectReferences.parallax_background.set_process(current_state == State.RUNNING)

func _handle_visibility() -> void:
	pass
