extends Node
class_name PillarSpawner

@onready var pillar: PackedScene = preload("res://scene/pillar.tscn")

func _spawn_pillar() -> void:
	var pillar_temp := pillar.instantiate()
	pillar_temp.position.x = get_viewport().get_visible_rect().end.x + 150
	pillar_temp.position.y = randf_range(80, 480 - 80)
	add_child(pillar_temp)

func _on_timer_timeout() -> void:
	_spawn_pillar()
