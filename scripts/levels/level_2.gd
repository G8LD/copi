extends Node2D

@onready var door: Area2D = $Door
"""
Level Mechanic:
	Button to open door and start timer
	Door closes at end of timer
	Need to reach the door before the timer stops
	Need to press button to restart timer
"""
@onready var button: Area2D = $Button
var buttonAnimation: AnimatedSprite2D

@onready var labeled_timer: CanvasLayer = $LabeledTimer
var timer: Timer
var label: Label

func _ready() -> void:
	timer = labeled_timer.get_node("Timer")
	timer.one_shot = true
	timer.wait_time = 30
	timer.timeout.connect(_on_timer_timeout)
	label = labeled_timer.get_node("Label")
	label.text = "30.00"
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
			label.add_theme_color_override("font_outline_color", Color())
	elif label.get_theme_color("font_color") != Color("FFF"):
		label.add_theme_color_override("font_color", Color("FFF"))
		label.add_theme_color_override("font_shadow_color", Color("f7aa30"))
		label.add_theme_color_override("font_outline_color", Color("f7aa30"))


func _on_button_pressed() -> void:
	door.open()
	timer.start()
	button.pressed = false


func _on_timer_timeout() -> void:
	label.text = str("%.2f" % timer.time_left)
	door.close()


func _on_door_body_entered(_body: Node2D) -> void:
	timer.paused = true
