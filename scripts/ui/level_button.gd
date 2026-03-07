extends Button

var level: int

func _ready() -> void:
	print(level)
	text = str(level)


func _on_pressed() -> void:
	print("test")
	get_tree().change_scene_to_file(str("res://scenes/levels/", level, ".tscn"))
