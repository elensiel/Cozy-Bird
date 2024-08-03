extends CharacterBody2D


@onready var sprite = $Sprite2D
@onready var audio_caw = $SFX/Caw
@onready var audio_flap = $SFX/Flap


const JUMP_VELOCITY := -350.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var fall_speed : int = 500
var rotation_speed : float = 0.04


func _unhandled_input(event) -> void:
	if owner.state != 2: # if not dead--we take input
		if event.is_action_pressed("flap"):
			## change pause state to running
			if owner.state == 0: # if pause
				owner.game_run()
			
			## to caw rng
			var rng = randi_range(1, 10)
			if rng <= 3: # 30% chance to caw
				caw()
			
			jump()
			audio_flap.play()
			sprite.frame = 1 # flapping frame
		
		if event.is_action_pressed("pause"):
			owner.game_pause()

func _physics_process(delta) -> void:
	if owner.state != 0: # if not pause
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

func jump() -> void:
	velocity.y = JUMP_VELOCITY
	rotation = deg_to_rad(-30)

func caw() -> void:
	audio_caw.play()
