extends Control
class_name MainMenu

func _enter_tree() -> void:
	# put node ref here
	var background: TextureRect = $TextureRect
	var panel: PanelContainer = $VBoxContainer/PanelContainer
	var button_container: VBoxContainer = $VBoxContainer/PanelContainer/CenterContainer/MarginContainer/VBoxContainer
	
	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	
	background.custom_minimum_size.x = viewport_size.x * 3
	background.custom_minimum_size.y = viewport_size.y
	
	panel.custom_minimum_size.x = viewport_size.x / 2
	panel.custom_minimum_size.y = viewport_size.x / 2
	
	for button in button_container.get_children():
		button.custom_minimum_size.x = panel.custom_minimum_size.x / 2
		button.custom_minimum_size.y = panel.custom_minimum_size.x / 4
