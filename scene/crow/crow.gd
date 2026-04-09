class_name Crow
extends CharacterBody2D

@onready var collision: CollisionShape2D = $CollisionShape2D

func _init() -> void:
	print("Crow: Setting up")
