extends Node2D
class_name Pillar

@onready var pillars : Array[Area2D] = [$TopPillar, $BottomPillar]
@onready var score_line: Area2D = $ScoreLine
@onready var score_line_collision: CollisionShape2D = $ScoreLine/CollisionShape2D

const DISTANCE: float = 100.0
const SPEED: float = 150
const PITCH_INCREASE: float = 0.005

var collisions : Array[CollisionShape2D]
var size: Vector2 = Vector2(0, 0)

func _ready() -> void:
	scale *= ViewportHelper.GetScaleModifier()
	
	# apply distance between top and bottom pillar
	$TopPillar.position.y -= DISTANCE * scale.y
	$BottomPillar.position.y += DISTANCE * scale.y
	
	for pillar in pillars:
		# connect the killing of crow signal
		pillar.connect("body_entered", Callable.create(self, "_on_pillar_body_entered"))
		
		for child in pillar.get_children():
			if child is CollisionShape2D:
				collisions.append(child)
				
				# get its width thru the widest collision shape
				if child.shape.size.x > size.x:
					size = child.shape.size
	
	score_line.position.x += size.x / 2

func _physics_process(delta: float) -> void:
	position.x -= SPEED * delta

## called whenever spawned or despawned
## enable collision when visible otherwise disable it
func update_detection() -> void:
	if get_parent():
		score_line_collision.disabled = !get_parent().visible
		for collision in collisions:
			collision.disabled = !get_parent().visible

## killing signal
func _on_pillar_body_entered(crow: Crow) -> void:
	if ObjectReferences.state_machine.current_state != ObjectReferences.state_machine.State.DYING:
		ObjectReferences.state_machine.call_deferred("change_state", StateMachine.State.DYING)
		crow.physics.Flap()

## score signal
func _on_score_line_body_entered(_crow: Crow) -> void:
	score_line_collision.set_deferred("disabled", true)
	ScoreManager.increase_score()
