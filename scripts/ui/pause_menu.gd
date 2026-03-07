extends CanvasLayer


@onready var options_label: Label = $options_label

func _unpause() -> void:
	visible = false
	get_tree().paused = false

func _ready() -> void:
	_unpause()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		visible = !get_tree().paused
		get_tree().paused = !get_tree().paused


func _on_resume_pressed() -> void:
	_unpause()


func _on_replay_pressed() -> void:
	get_tree().reload_current_scene()


func _on_levels_pressed() -> void:
	_unpause()
	get_tree().change_scene_to_file("res://scenes/ui/level_menu.tscn")


func _on_options_pressed() -> void:
	options_label.visible = !options_label.visible


func _on_quit_pressed() -> void:
	get_tree().quit()
