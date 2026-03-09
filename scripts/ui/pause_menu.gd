extends CanvasLayer


@onready var options_label: Label = $options_label
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var quit: Button = $VBoxContainer/Quit
var is_paused = true # Local variable to know if this is the node that paused the tree

func _ready() -> void:
	_unpause()
	if OS.get_name() == "Web":
		v_box_container.remove_child(quit)
	v_box_container.size.y = v_box_container.get_child_count() * 75


func _unpause() -> void:
	visible = false
	get_tree().paused = false
	is_paused = false


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		# Check if tree paused and unpause only if is_paused is true
		if get_tree().paused:
			if is_paused:
				_unpause()
		else:
			visible = true
			get_tree().paused = true
			is_paused = true


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
