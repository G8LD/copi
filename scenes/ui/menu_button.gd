extends Button


func _ready() -> void:
	if get_index() == 0:
		grab_focus()

func _on_mouse_entered() -> void:
	grab_focus()


func _on_visibility_changed() -> void:
	if get_index() == 0:
		grab_focus()
