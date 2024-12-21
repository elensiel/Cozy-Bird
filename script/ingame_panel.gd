extends Node
class_name IngamePanel

func _ready() -> void:
	var panel_container := $PanelContainer
	var panel := $Panel
	var viewport := get_viewport().get_visible_rect()
	
	panel.size = viewport.size
	panel_container.position = (viewport.size / 2) - (panel_container.size / 2)
