extends Area2D

signal player_died

func _on_body_entered(body):
	if body.name == "Player":
		owner.player_dead()
