"""
Level Mechanic:
	Door is closed
	Need to go on moving platform and jump on button
	Fall to respawn at the top of the screen and end on moving platform
"""
extends Node2D

@onready var button: Area2D = $Button
@onready var door: Area2D = $Door

func _ready() -> void:
	button.get_node("AnimatedSprite2D").animation_finished.connect(door.open)
