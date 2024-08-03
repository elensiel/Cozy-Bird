extends ParallaxBackground

var scrolling_speed = 10

func _process(delta):
	if owner.state == 1:
		scroll_offset.x -= scrolling_speed * delta
