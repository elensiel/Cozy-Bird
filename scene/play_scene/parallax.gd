extends CanvasLayer

const SCROLL_SPEED: float = 12.5

func _init() -> void:
	print("Parallax: Setting up")

func _ready() -> void:
	# get scaled width
	var sprite: Sprite2D = $Back/Background
	var scaled_width := sprite.texture.get_width() * sprite.scale.x
	
	# parallax scrolling speed
	# back -> slower, front -> faster
	var base_scroll_speed := -5.0
	var scroll_speed_step := 5.0
	var current_speed := base_scroll_speed
	
	for parallax: Parallax2D in get_children():
		# set repeating width first
		parallax.repeat_size.x = scaled_width
		
		# randomize bg starting point after
		parallax.scroll_offset.x = randf_range(0, scaled_width)
		
		parallax.autoscroll.x = current_speed
		current_speed -= scroll_speed_step
