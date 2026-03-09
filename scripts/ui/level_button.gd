extends Button

var level: int

func _ready() -> void:
	text = str(level)
	if get_index() == 0: 
		grab_focus()


func _on_pressed() -> void:
	get_tree().change_scene_to_file(str("res://scenes/levels/level_", level, ".tscn"))


func _on_mouse_entered() -> void:
	grab_focus()
