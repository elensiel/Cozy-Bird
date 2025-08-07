extends CharacterBody2D
class_name Crow

@onready var physics: Node = $PhysicsLogic
@onready var collision: CollisionShape2D = $CollisionShape2D

const JUMP_VELOCITY: float = -350.0
const JUMP_ROTATION: float = -30.0
const MAX_FALL_SPEED: float = 1000
const ROTATION_SPEED: float = 0.04
const CAW_CHANCE: int = 25 # % chance of caw sfx on flap

func _init() -> void:
	print("Crow: Setting up")
	
	ObjectReferences.crow = self

func _enter_tree() -> void:
	scale *= ViewportHelper.GetScaleModifier()
	position = ViewportHelper.GetCurrentViewport().size / 2

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("flap"):
		if ObjectReferences.state_machine.current_state == StateMachine.State.NEW:
			ObjectReferences.state_machine.change_state(StateMachine.State.RUNNING)
		
		physics.Flap()
		AudioManager.flap.play()
		if randi_range(1, 100) <= CAW_CHANCE: AudioManager.caw.play()
		
	elif event.is_action_pressed("ui_cancel"):
		ObjectReferences.state_machine.change_state(StateMachine.State.PAUSED)
