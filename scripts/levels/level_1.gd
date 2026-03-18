"""
Level Mechanic:
	Door is closed
	Need to go on moving platform and jump on button
	Fall to respawn at the top of the screen and end on moving platform
"""
extends Node2D

@onready var button: Area2D = $Button
@onready var door: Area2D = $Door


func _process(_delta: float) -> void:
	if button.pressed and !door.is_open:
		door.open()
