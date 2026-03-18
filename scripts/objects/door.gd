extends Area2D

@onready var player: CharacterBody2D = %Player
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var win_message: CanvasLayer = $WinMessage
var win_label_animation_player: AnimationPlayer;

@export var is_open: bool = false

func _ready() -> void:
	animated_sprite_2d.animation = "open"
	win_label_animation_player =  win_message.get_node("Label/AnimationPlayer")
	win_label_animation_player.animation_finished.connect(end_level)

func _on_body_entered(_body: Node2D) -> void:
	if is_open:
		win_message.visible = true
		player.visible = false
		get_tree().paused = true
		win_label_animation_player.play("slide")


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


func end_level(_anim_name: String) -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/level_menu.tscn")
