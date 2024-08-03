extends Node2D

## REFERENCES
@onready var player = $Player
@onready var dead_zone = $"Dead Zone"
@onready var death_timer = $"Death Timer"
@onready var spawn_timer = $"Spawn Timer"
@onready var ui = $UI
@onready var bg = $BG
@onready var score_label = $UI/score_label
@onready var game_manager = $"Game Manager"

## VARIABLES
enum STATES { PAUSE, RUNNING, DEAD, }
var state : int

## ~preloads
var pillar = preload("res://scene/pillar.tscn")
var restart = preload("res://scene/try_again_panel.tscn")
var pause = preload("res://scene/pause_panel.tscn")


## FUNCTIONS
func _ready() -> void:
	state = STATES.PAUSE
	spawn_pillar()
	spawn_timer.set_paused(true)
	
	## for restart purposes
	#score_label.visible = true

func game_pause() -> void:
	state = STATES.PAUSE
	
	## instantiate pause panel
	var pause_temp = pause.instantiate()
	add_child(pause_temp)
	
	get_tree().paused = true

func game_run() -> void:
	state = STATES.RUNNING
	spawn_timer.set_paused(false)
	ui.visibility(false)

func player_dead() -> void:
	## one jump bfr falling
	if state != STATES.DEAD:
		player.jump()
		player.caw()
	
	state = STATES.DEAD
	death_timer.start()
	spawn_timer.stop()

func spawn_pillar() -> void:
	var pillar_temp = pillar.instantiate()
	pillar_temp.position.x = (get_viewport().get_visible_rect().end.x) + 200
	pillar_temp.position.y = randf_range(100, 400)
	add_child(pillar_temp)


## SIGNALS
func _on_spawn_timer_timeout() -> void:
	if state == STATES.RUNNING:
		spawn_pillar()
	else:
		spawn_timer.stop()

func _on_death_timer_timeout() -> void:
	game_manager.check_high_score()
	var restart_temp = restart.instantiate()
	add_child(restart_temp)
	
	## label visibility
	score_label.visible = false

## pillar despawner
func _on_pillar_free_area_entered(area) -> void:
	area.queue_free()
