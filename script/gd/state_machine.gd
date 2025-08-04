extends Node

enum State {
	NEW,
	RUNNING,
	PAUSED,
	DYING,
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
		State.DYING:
			_handle_dying()
		State.DEAD:
			_handle_dead()
	
	_handle_collisions()
	_handle_processes()
	_handle_visibility()

func _handle_new() -> void:
	pass

func _handle_running() -> void:
	if ObjectReferences.spawn_timer.is_stopped():
		ObjectReferences.spawn_timer.start()

func _handle_paused() -> void:
	pass

func _handle_dying() -> void:
	ObjectReferences.spawn_timer.stop()
	ObjectReferences.death_timer.start()

func _handle_dead() -> void:
	pass

func _handle_collisions() -> void:
	ObjectReferences.crow.collision.disabled = !current_state == State.RUNNING
	
	# bounding wall
	for area in ObjectReferences.walls.get_children():
		for collision in area.get_children():
			collision.disabled = !current_state == State.RUNNING
	
	# pillar's
	for pillar in ObjectReferences.spawn_machine.active.get_children():
		for collision in pillar.collisions:
			collision.disabled = !current_state == State.RUNNING

func _handle_processes() -> void:
	# Crow processes
	ObjectReferences.crow.physics.set_physics_process(current_state == State.RUNNING or current_state == State.DYING)
	ObjectReferences.crow.set_process_unhandled_input(
		current_state == State.NEW or current_state == State.RUNNING)
		#current_state != State.DEAD and current_state != State.PAUSED and current_state != State.DYING)
	
	# ParallaxBackground
	ObjectReferences.parallax_background.set_process(current_state == State.RUNNING)
	
	# pillars
	for pool in ObjectReferences.spawn_machine.get_children():
		if pool is Node2D:
			for pillar in pool.get_children():
				pillar.set_physics_process(current_state == State.RUNNING)
	
	# spawn timer
	ObjectReferences.spawn_timer.paused = current_state != State.RUNNING

func _handle_visibility() -> void:
	ObjectReferences.ui_elements.visible = (current_state == State.PAUSED) or (current_state == State.DEAD)
	#ObjectReferences.ui_elements.panel.visible = (current_state == State.PAUSED) or (current_state == State.DEAD)
	ObjectReferences.ui_elements.retry_panel.visible = (current_state == State.DEAD)
	ObjectReferences.ui_elements.pause_panel.visible = (current_state == State.PAUSED)
