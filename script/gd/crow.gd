extends CharacterBody2D
class_name Crow

@onready var physics: Node = $PhysicsLogic

const JUMP_VELOCITY: float = -350.0
const JUMP_ROTATION: float = -30.0
const MAX_FALL_SPEED: float = 1000
const ROTATION_SPEED: float = 0.04

func _init() -> void:
	ObjectReferences.crow = self

func _enter_tree() -> void:
	var target_size: Vector2 = Vector2(480, 1080)
	var current_viewport_size: Vector2 = get_viewport().get_visible_rect().size
	scale *= current_viewport_size / target_size
	position = get_viewport().get_visible_rect().size / 2

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		if StateMachine.current_state == StateMachine.State.NEW:
			StateMachine.change_state(StateMachine.State.RUNNING)
		
		physics.Flap()
	elif event.is_action_pressed("ui_cancel"):
		StateMachine.change_state(StateMachine.State.PAUSED)
