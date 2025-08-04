extends CharacterBody2D
class_name Crow

@onready var physics: Node = $PhysicsLogic
@onready var collision: CollisionShape2D = $CollisionShape2D

const JUMP_VELOCITY: float = -350.0
const JUMP_ROTATION: float = -30.0
const MAX_FALL_SPEED: float = 1000
const ROTATION_SPEED: float = 0.04

func _init() -> void:
	ObjectReferences.crow = self

func _enter_tree() -> void:
	scale *= ViewportHelper.GetCalculatedScale()
	position = ViewportHelper.GetCurrentViewport().size / 2

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		if StateMachine.current_state == StateMachine.State.NEW:
			StateMachine.change_state(StateMachine.State.RUNNING)
		
		physics.Flap()
		AudioManager.flap.play()
		if randi_range(0, 10) <= 3: AudioManager.caw.play()
		
	elif event.is_action_pressed("ui_cancel"):
		StateMachine.change_state(StateMachine.State.PAUSED)
