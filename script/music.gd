extends AudioStreamPlayer2D

@onready var music = $"."
@onready var menu = get_node("/root/Menu")

func _ready():
	menu.music_toggle_on.connect(on_music_toggle_on)
	menu.music_toggle_off.connect(on_music_toggle_off)

func _on_finished():
	music.play()

func on_music_toggle_on():
	volume_db = -80

func on_music_toggle_off():
	volume_db = 0
