extends Node2D

@onready var door: Area2D = $Door
@onready var timer: Timer = $Timer
@onready var button: Area2D = $Button
@onready var label: Label = $CanvasLayer/Label
var buttonAnimation: AnimatedSprite2D


func _ready() -> void:
	timer.one_shot = true
	timer.wait_time = 30
	buttonAnimation = button.get_node("AnimatedSprite2D")
	buttonAnimation.animation = "loop"
	buttonAnimation.animation_finished.connect(_on_button_pressed)


func _process(_delta: float) -> void:
	if !timer.is_stopped():
		set_label_color()
		label.text = str("%.2f" % timer.time_left)


func set_label_color() -> void:	
	if timer.time_left < 5:
		if label.get_theme_color("font_shadow_color") != Color():
			label.add_theme_color_override("font_color", Color("fe3b1e"))
			label.add_theme_color_override("font_shadow_color", Color())
	elif label.get_theme_color("font_color") != Color("FFF"):
		label.add_theme_color_override("font_color", Color("FFF"))
		label.add_theme_color_override("font_shadow_color", Color("f7aa30"))


func _on_button_body_entered(_body: Node2D) -> void:
	if !button.pressed and !buttonAnimation.is_playing():
		button.pressed = true
		timer.start()
		buttonAnimation.play()


func _on_button_pressed() -> void:
	door.open()
	timer.start()
	button.pressed = false


func _on_timer_timeout() -> void:
	door.close()
