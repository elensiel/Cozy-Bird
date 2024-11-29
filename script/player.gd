extends CharacterBody2D

@onready var main: Node = owner as GameStateMachine
@onready var sprite: Sprite2D = $Sprite2D
@onready var camera: Camera2D = %Camera2D

const JUMP_VELOCITY := -350.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var fall_speed: int = 500
var rotation_speed: float = 0.04

func _ready() -> void:
	var rand_pos = randi() % 1505
	
	position.x += rand_pos
	camera.position.x += rand_pos

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		if main.current_state == GameStateMachine.GameState.PAUSED:
			main.set_state(GameStateMachine.GameState.RUNNING)
		_jump()

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

func _jump() -> void:
	velocity.y = JUMP_VELOCITY
	rotation = deg_to_rad(-30)
