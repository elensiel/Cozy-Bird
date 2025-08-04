extends Node
class_name SpawnMachine

@onready var active: Node2D = $Active
@onready var hold: Node2D = $Hold
@onready var timer: Timer = $Timer
@onready var spawn_helper: Node = $SpawnHelper

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

func spawn(pillar: Pillar) -> void:
	# set position
	var x: float = ViewportHelper.GetCurrentViewport().end.x + (pillar.size.x / 2)
	var y: float = spawn_helper.GetRandomHeight(ViewportHelper.GetCurrentViewport().size)
	pillar.position = Vector2(x, y)
	
	# pooling
	if pillar.get_parent() == hold:
		hold.remove_child(pillar)
	if pillar.get_parent() != active:
		active.add_child(pillar)
	
	pillar.update_detection()
	pillar.set_physics_process(true) # enable movement

func despawn(pillar: Pillar) -> void:
	pillar.set_physics_process(false) # disable movement
	
	# pooling
	if pillar.get_parent() == active:
		active.remove_child(pillar)
	if pillar.get_parent() != hold:
		hold.add_child(pillar)
	
	pillar.update_detection()

func _on_timer_timeout() -> void:
	spawn(hold.get_child(hold.get_child_count() - 1))     
