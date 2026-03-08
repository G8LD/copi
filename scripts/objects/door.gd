extends Area2D

@onready var player: CharacterBody2D = %Player
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@export var is_open: bool = false

func _on_body_entered(_body: Node2D) -> void:
	if is_open:
		timer.start()
		player.quit()


func open() -> void:
	if !is_open and !animated_sprite_2d.is_playing():
		animated_sprite_2d.animation = "open"
		animated_sprite_2d.play()
		is_open = true


func close() -> void:
	if is_open and !animated_sprite_2d.is_playing():
		animated_sprite_2d.animation = "close"
		animated_sprite_2d.play()
		is_open = false


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/level_menu.tscn")
