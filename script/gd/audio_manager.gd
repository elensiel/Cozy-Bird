extends Node

@onready var button_press: AudioStreamPlayer = $ButtonPress
@onready var caw: AudioStreamPlayer = $Caw
@onready var flap: AudioStreamPlayer = $Flap
@onready var score: AudioStreamPlayer = $Score

func _init() -> void:
	print("AudioManager: Setting up")

func play_button_press() -> void:
	button_press.play()
	await button_press.finished
