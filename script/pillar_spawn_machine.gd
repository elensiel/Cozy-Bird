extends Node
class_name PillarSpawnMachine

@onready var pillar: PackedScene = preload("res://scene/pillar.tscn")
@onready var despawn: Area2D = $Despawn

var pillar_temp: Area2D

func _ready() -> void:
	despawn.position.x -= get_viewport().get_visible_rect().size.x / 2

func _spawn_pillar() -> void:
	pillar_temp = pillar.instantiate()
	pillar_temp.position.x = get_viewport().get_visible_rect().end.x + 200
	pillar_temp.position.y = randf_range(240, 480 - 40)
	add_child(pillar_temp)

func _on_timer_timeout() -> void:
	_spawn_pillar()

func _on_despawn_area_entered(area: Area2D) -> void:
	area.get_parent().queue_free()
