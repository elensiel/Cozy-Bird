extends Area2D
#class_name DespawnZone

func _ready() -> void:
	position.x -= get_viewport().get_visible_rect().size.x / 2        

func _on_area_entered(area: Area2D) -> void:
	var parent: Node2D = area.get_parent()
	if parent is Pillar:
		ObjectReferences.spawn_machine.call_deferred_thread_group("despawn", parent)
