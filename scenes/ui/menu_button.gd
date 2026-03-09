extends Button


func _ready() -> void:
	if get_index() == 0:
		call_deferred("grab_focus")


func _on_mouse_entered() -> void:
		call_deferred("grab_focus")


func _on_visibility_changed() -> void:
	if is_node_ready() and get_index() == 0:
		call_deferred("grab_focus")
