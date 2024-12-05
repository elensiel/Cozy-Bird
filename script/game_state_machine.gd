extends Node
class_name GameStateMachine


## REFERENCES
@onready var timer: Timer = $PillarSpawnMachine/Timer
@onready var parallax: ParallaxBackground = $ParallaxBackground
@onready var player: CharacterBody2D = $Player
@onready var death_timer: Timer = $DeathTimer
@onready var game_manager: GameManager = $GameManager


## VARIABLES
enum GameState { PAUSED, RUNNING, DEAD }
var current_state: GameState


## FUNCTIONS
func _ready() -> void:
	set_state(GameState.PAUSED)
	
	## disabling some nodes on start
	parallax.set_process(false) # pause parallax scrolling
	timer.set_paused(true) # pause timer

func set_state(new_state: GameState):
	_exit_state(current_state)
	current_state = new_state
	_enter_state(current_state)

func _exit_state(state: GameState):
	match state:
		GameState.PAUSED:
			player.set_physics_process(true) # run player physics
		GameState.RUNNING:
			parallax.set_process(false) # pause parallax scrolling
			timer.set_paused(true) # pause timer
		GameState.DEAD:
			get_tree().paused = false
			player.set_process_input(true) # run player input

func _enter_state(state: GameState):
	match state:
		GameState.PAUSED:
			player.set_physics_process(false) # run player physics
		GameState.RUNNING:
			parallax.set_process(true) # run parallax scrolling
			timer.set_paused(false) # run timer
		GameState.DEAD:
			player.set_process_input(false) # pause player input
			game_manager.save_high_score()
			death_timer.start() # start death timer
