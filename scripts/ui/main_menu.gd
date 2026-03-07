extends Control

@onready var options_label: Label = $options_label
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var quit: Button = $VBoxContainer/Quit


func _ready() -> void:
	if OS.get_name() == "Web":
		v_box_container.remove_child(quit)
	v_box_container.size.y = v_box_container.get_child_count() * 75

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/level_menu.tscn")


func _on_options_pressed() -> void:
	options_label.visible = !options_label.visible

func _on_quit_pressed() -> void:
	get_tree().quit()
