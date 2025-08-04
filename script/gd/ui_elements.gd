extends Control
class_name UiElements

@onready var panel: Panel = $Panel
@onready var pause_panel: PanelContainer = $PausePanel
@onready var retry_panel: PanelContainer = $RetryPanel
@onready var pause_button: Button = $MarginContainer/Pause

func _init() -> void: ObjectReferences.ui_elements = self

func _ready() -> void:
	ScoreManager.current_score_label = $CenterContainer/ScoreLabel

func _on_continue_pressed() -> void:
	AudioManager.play_button_press()
	StateMachine.change_state(StateMachine.previous_state)

func _on_retry_pressed() -> void:
	AudioManager.play_button_press()
	get_tree().reload_current_scene()

func _on_main_menu_pressed() -> void:
	AudioManager.play_button_press()
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")

func _on_pause_pressed() -> void:
	AudioManager.play_button_press()
	StateMachine.change_state(StateMachine.State.PAUSED)
