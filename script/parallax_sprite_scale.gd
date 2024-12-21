extends Sprite2D
class_name ParallaxSpriteScale

func _ready() -> void:
	var viewport := get_viewport().get_visible_rect()
	
	scale.x = (viewport.size.x * 4) / texture.get_width()
	scale.y = viewport.size.y / texture.get_height()
	
	position = viewport.position
