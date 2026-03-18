extends Control

const LEVEL_BUTTON = preload("res://scenes/ui/level_button.tscn")

@onready var grid_container: GridContainer = $GridContainer

var nb_levels = 3

func _ready() -> void:
	init_level_buttons()
	if nb_levels < grid_container.columns:
		grid_container.columns = nb_levels

func init_level_buttons():
	for level in nb_levels:
		var level_button = LEVEL_BUTTON.instantiate()
		level_button.level = level+1
		grid_container.add_child(level_button)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
