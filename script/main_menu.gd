extends Node

@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var game_loop: PackedScene = preload("res://scene/game_loop.tscn")

func _ready() -> void:
	var viewport_size := get_viewport().get_visible_rect().size
	var panel_container := $PanelContainer
	var label := $Label
	var sprite := $Sprite2D
	
	panel_container.position.x = (viewport_size.x / 2) - (panel_container.size.x / 2)
	panel_container.position.y = (viewport_size.y / 2) - (panel_container.size.y / 2)
	
	label.text = "HIGH SCORE: " + str(GameManager.load_score()) # display high score
	label.position.x = (viewport_size.x / 2) - (label.size.x / 2)
	label.position.y = panel_container.position.y - label.size.y
	
	panel_container = null
	label = null
	
	sprite.scale.x = (viewport_size.x * 2) / sprite.texture.get_width()
	sprite.scale.y = viewport_size.y / sprite.texture.get_height()
	sprite.position.x = viewport_size.x
	sprite.position.y = viewport_size.y / 2

func _on_play_pressed() -> void:
	audio.play()
	await audio.finished
	get_tree().change_scene_to_packed(game_loop)

func _on_quit_pressed() -> void:
	audio.play()
	await audio.finished
	get_tree().quit()
