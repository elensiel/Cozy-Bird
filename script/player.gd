extends CharacterBody2D
class_name Player


## REFERENCES
@onready var caw: AudioStreamPlayer2D = $Caw
@onready var flap: AudioStreamPlayer2D = $Flap
@onready var main: Node = owner as GameStateMachine
@onready var sprite: Sprite2D = $Sprite2D


## VARIABLES
const JUMP_VELOCITY := -350.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var fall_speed: int = 1000
var rotation_speed: float = 0.04


## FUNCTIONS
## processes
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		if main.current_state == GameStateMachine.GameState.PAUSED:
			main.set_state(GameStateMachine.GameState.RUNNING)
		jump()
		flap.play()
		if randi_range(0, 10) <= 3:
			caw.play()
	elif event.is_action_pressed("pause"):
		match main.current_state:
			GameStateMachine.GameState.RUNNING:
				main.set_state(GameStateMachine.GameState.PAUSED)
			GameStateMachine.GameState.PAUSED:
				main.set_state(GameStateMachine.GameState.RUNNING)

func _physics_process(delta: float) -> void:
	## gravity
	velocity.y += gravity * delta
	velocity.y = min(velocity.y, fall_speed) # max falling speed
	
	## rotation
	if velocity.y > 0 and rad_to_deg(rotation) < 90: # downward
		rotation += rotation_speed * rad_to_deg(1) * delta
		sprite.frame = 0
	elif velocity.y < 0 and rad_to_deg(rotation) > 0: # upward
		rotation -= rotation_speed * rad_to_deg(1) * delta
	
	move_and_collide(velocity * delta)

## customs
func jump() -> void:
	velocity.y = JUMP_VELOCITY
	rotation = deg_to_rad(-30)
	sprite.frame = 1
