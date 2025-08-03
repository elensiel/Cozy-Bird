extends Node
class_name SpawnMachine

@onready var active: Node2D = $Active
@onready var hold: Node2D = $Hold
@onready var timer: Timer = $Timer

const INITIAL_COUNT: int = 5
const HEIGHT_RANGE: float = 100

func _init() -> void:
	ObjectReferences.spawn_machine = self

func _ready() -> void:
	ObjectReferences.spawn_timer = timer
	var pillar_scene: PackedScene = preload("res://scene/pillar.tscn")
	
	for i in INITIAL_COUNT:
		var instance: Pillar = pillar_scene.instantiate()
		despawn(instance)
		instance.position.x = get_viewport().get_visible_rect().end.x # avoid being detected by despawn zone      

func spawn(pillar: Pillar) -> void:
	# set position
	var x: float = get_viewport().get_visible_rect().end.x + (pillar.get_size().x / 2)
	var y: float = _get_random_height()
	pillar.position = Vector2(x, y)
	
	# pooling
	if pillar.get_parent() == hold:
		hold.remove_child(pillar)
	if pillar.get_parent() != active:
		active.add_child(pillar)
	
	pillar.update_detection()
	pillar.set_physics_process(true) # enable movement
	
	print(active.get_child_count())

func despawn(pillar: Pillar) -> void:
	pillar.update_detection()
	pillar.set_physics_process(false) # disable movement
	
	# pooling
	if pillar.get_parent() == active:
		active.remove_child(pillar)
	if pillar.get_parent() != hold:
		hold.add_child(pillar)

func _get_random_height() -> float:
	var midpoint: float = get_viewport().get_visible_rect().size.y / 2
	return midpoint + randf_range(-HEIGHT_RANGE, HEIGHT_RANGE)

func _on_timer_timeout() -> void:
	spawn(hold.get_child(hold.get_child_count() - 1))     
