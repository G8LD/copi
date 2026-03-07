extends Control

const LEVEL_BUTTON = preload("res://scenes/ui/level_button.tscn")

@onready var grid_container: GridContainer = $GridContainer

var nb_levels = 0

func _ready() -> void:
	init_level_buttons()
	if nb_levels < grid_container.columns:
		grid_container.columns = nb_levels

func init_level_buttons():
	var dir = DirAccess.open("res://scenes/levels")
	dir.list_dir_begin()

	var file_name = dir.get_next()
	while file_name != "":
		var level = int(file_name.remove_chars(".tscn"))

		var level_button = LEVEL_BUTTON.instantiate()
		level_button.level = level
		grid_container.add_child(level_button)
		nb_levels+=1

		file_name = dir.get_next()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
