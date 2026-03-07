extends Control

@onready var options_label: Label = $options_label

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_menu.tscn")


func _on_options_pressed() -> void:
	options_label.visible = !options_label.visible


func _on_quit_pressed() -> void:
	get_tree().quit()
