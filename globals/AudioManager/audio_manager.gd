extends Node

enum Ambience {
	HARBOR,
	DOWNTOWN,
}

@onready var button_press: AudioStreamPlayer = $SFX/ButtonPress
@onready var caw: AudioStreamPlayer = $SFX/Caw
@onready var flap: AudioStreamPlayer = $SFX/Flap
@onready var score: AudioStreamPlayer = $SFX/Score
@onready var ambience_stream: AudioStreamInteractive = $Ambience.stream
@onready var ambience_playback: AudioStreamPlaybackInteractive = $Ambience.get_stream_playback()

var current_ambience: Ambience

func _init() -> void:
	print("AudioManager: Setting up")

func _ready() -> void:
	# smooth opening ambience
	var ambience_player: AudioStreamPlayer = $Ambience
	var ambience_tween := ambience_player.create_tween()
	ambience_tween.tween_property(ambience_player, "volume_db", 0.0, 1.5)

func play_button_press() -> void:
	button_press.play()
	await button_press.finished

func play_ambience(ambience: Ambience) -> void:
	current_ambience = ambience
	
	var next_clip: int
	match current_ambience:
		Ambience.HARBOR:
			next_clip = 0 if ambience_playback.get_current_clip_index() == 1 else 1
		Ambience.DOWNTOWN:
			next_clip = 2 if ambience_playback.get_current_clip_index() == 3 else 3
	
	ambience_playback.switch_to_clip(next_clip)
	
	# initialize transition to itself
	#await get_tree().create_timer(5.0).timeout
	next_clip = ambience_stream.get_clip_auto_advance_next_clip(next_clip)
	ambience_playback.switch_to_clip(next_clip)

func _on_ambience_finished() -> void:
	play_ambience(current_ambience)
