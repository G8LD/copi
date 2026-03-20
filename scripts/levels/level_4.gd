"""
Level Mechanic:
	Maze
	Press button to open door
"""
extends Node2D

@onready var button: Area2D = $Button
@onready var door: Area2D = $Door

func _ready() -> void:
	button.get_node("AnimatedSprite2D").animation_finished.connect(door.open)
