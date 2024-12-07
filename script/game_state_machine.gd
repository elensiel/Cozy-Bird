extends Node
class_name GameStateMachine


## REFERENCES
@onready var death_timer: Timer = $DeathTimer
@onready var game_manager: GameManager = $GameManager
@onready var parallax: ParallaxBackground = $ParallaxBackground
@onready var pause_button: Button = $PauseButton
@onready var pause_panel: PackedScene = preload("res://scene/pause_panel.tscn")
@onready var player: CharacterBody2D = $Player as Player
@onready var timer: Timer = $PillarSpawnMachine/Timer


## VARIABLES
enum GameState { PAUSED, RUNNING, DEAD }
var current_state: GameState
var pause_panel_temp: Node
var start: bool = false
var jumped: bool = false


## FUNCTIONS
func _ready() -> void:
	set_state(GameState.PAUSED)
	
	## disabling some nodes on start
	parallax.set_process(false) # pause parallax scrolling
	timer.set_paused(true) # pause timer
	start = true

func set_state(new_state: GameState):
	_exit_state(current_state)
	current_state = new_state
	_enter_state(current_state)

func _exit_state(state: GameState):
	match state:
		GameState.PAUSED:
			player.set_physics_process(true) # run player physics
			
			# qfree pause panel
			if get_node("PausePanel") != null:
				get_node("PausePanel").queue_free()
		GameState.RUNNING:
			player.set_process_input(false) # disable _input
			parallax.set_process(false) # pause parallax scrolling
			timer.set_paused(true) # pause timer
		GameState.DEAD:
			get_tree().paused = false
			player.set_process_input(true) # run player input

func _enter_state(state: GameState):
	match state:
		GameState.PAUSED:
			player.set_physics_process(false) # run player physics
			
			# instantiate pause panel
			if start:
				pause_panel_temp = pause_panel.instantiate()
				add_child(pause_panel_temp)
		GameState.RUNNING:
			player.set_process_input(true) # enable _input
			parallax.set_process(true) # run parallax scrolling
			timer.set_paused(false) # run timer
		GameState.DEAD:
			player.set_process_input(false) # pause player input
			if not jumped:
				jumped = true
				player.jump()
			
			game_manager.save_high_score() 
			death_timer.start()
