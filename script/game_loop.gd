extends Node
class_name GameStateMachine

## REFERENCES
@onready var player: CharacterBody2D = get_node("Player")
@onready var parallax: ParallaxBackground = get_node("ParallaxBackground")
@onready var timer: Timer = $PillarSpawner/Timer


## VARIABLES
enum GameState { PAUSED, RUNNING, DEAD }
var current_state: GameState

## FUNCTIONS
func _ready() -> void:
	set_state(GameState.PAUSED)

func set_state(new_state: GameState):
	_exit_state(current_state)
	current_state = new_state
	_enter_state(current_state)

func _exit_state(state: GameState):
	match state:
		GameState.PAUSED:
			# run player physics
			player.set_physics_process(true)
		GameState.RUNNING:
			# pause parallax scrolling
			parallax.set_process(false)
			# pause pillar spawn timer
			timer.set_paused(true)
		GameState.DEAD:
			# run player input
			player.set_process_input(true)

func _enter_state(state: GameState):
	match state:
		GameState.PAUSED:
			# run player physics
			player.set_physics_process(false)
		GameState.RUNNING:
			# run parallax scrolling
			parallax.set_process(true) 
			# run pillar spawn timer
			timer.set_paused(false)
		GameState.DEAD:
			# pause player input
			player.set_process_input(false)
