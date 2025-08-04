extends Node2D
class_name Pillar

const DISTANCE: float = 100.0
const SPEED: float = 150

var collisions : Array[CollisionShape2D]
var size: Vector2 = Vector2(0, 0)

func _ready() -> void:
	scale *= ViewportHelper.GetCalculatedScale()
	
	# apply distance between top and bottom pillar
	$TopPillar.position.y -= DISTANCE * scale.y
	$BottomPillar.position.y += DISTANCE * scale.y
	
	# connect detection signal
	for child in get_children(): 
		child.connect("body_entered", Callable.create(self, "_on_pillar_body_entered"))
	
	# get collision for easier access later
	for area in get_children():
		for child in area.get_children():
			if child is CollisionShape2D:
				collisions.append(child)
				
				# setting the most wide shape size
				if child.shape.size.x > size.x:
					size = child.shape.size

func _physics_process(delta: float) -> void:
	position.x -= SPEED * delta

## called whenever spawned or despawned
## enable collision when visible otherwise disable it
func update_detection() -> void:
	if get_parent():
		for collision in collisions:
			collision.disabled = !get_parent().visible

func _on_pillar_body_entered(crow: Crow) -> void:
	if StateMachine.current_state != StateMachine.State.DYING:
		StateMachine.call_deferred("change_state", StateMachine.State.DYING)
		crow.physics.Flap()
