extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var pressed = false


func _on_body_entered(_body: Node2D) -> void:
	if !pressed and !animated_sprite_2d.is_playing():
		animated_sprite_2d.play() 
		pressed = true

func unpress() -> void:
	animated_sprite_2d.stop()
	pressed = false
