extends Node2D
class_name Pillar

const DISTANCE: float = 100.0
const SPEED: float = 100

var collisions : Array[CollisionShape2D]

func _ready() -> void:
	$TopPillar.position.y -= DISTANCE
	$BottomPillar.position.y += DISTANCE
	
	for area in get_children():
		for child in area.get_children():
			if child is CollisionShape2D:
				collisions.append(child)

func _physics_process(delta: float) -> void:
	position.x -= SPEED * delta

func get_size() -> Vector2:
	var shape: RectangleShape2D = collisions[0].shape
	return shape.size

func update_detection() -> void:
	if get_parent():
		for collision in collisions:
			collision.disabled = !get_parent().visible
