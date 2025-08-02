extends ParallaxBackground
class_name ParallaxManager

const SCROLL_SPEED: float = 12.5

func _init() -> void:
	ObjectReferences.parallax_background = self

func _ready() -> void:
	var viewport: Vector2 = get_viewport().get_visible_rect().size
	var width_modifier: int = 5
	var motion_scale_modifier: float = 0.6
	
	# randomize bg starting point
	scroll_base_offset.x = randf_range(0, (viewport.x * width_modifier) - viewport.x)
	
	for layer_node in get_children():
		layer_node.motion_mirroring.x = viewport.x * width_modifier
		layer_node.motion_scale.x -= motion_scale_modifier
		motion_scale_modifier -= 0.2
		
		# ensure texture sizing on different devices
		for texture in layer_node.get_children():
			texture.expand_mode = TextureRect.ExpandMode.EXPAND_IGNORE_SIZE
			texture.custom_minimum_size.x = viewport.x * width_modifier
			texture.custom_minimum_size.y = viewport.y

func _process(delta: float) -> void:
	scroll_offset.x -= SCROLL_SPEED * delta
