extends Node2D

@onready var main = get_parent()
@onready var audio = $AudioStreamPlayer
@onready var game_manager = main.find_child("Game Manager")

const SPEED = 100

func _physics_process(delta) -> void:
	if main.state == 1: # if running
		position.x -= SPEED * delta

func _on_point_reg_body_entered(body) -> void:
	if body.name == "Player":
		audio.play()
		game_manager.update_score()

func _on_body_entered(body) -> void:
	if body.name == "Player":
		main.player_dead()
