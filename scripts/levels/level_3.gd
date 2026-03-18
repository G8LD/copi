"""
Level Mechanic:
	Round: Display a sequence of light. Press the button in the order
		Win: Progress to next round
		Lose: Restart from round 1
	Number of rounds: 3
	End of round 3: Door opens
"""

extends Node2D

@onready var door: Area2D = $Door
@onready var labeled_timer: CanvasLayer = $LabeledTimer
@onready var light_cubes: Node2D = $LightCubes
@onready var buttons: Node2D = $Buttons
@onready var progression_cubes: Node2D = $ProgressionCubes
var timer: Timer
var label: Label

var sequence: Array[int]
var sequence_length = 5
var animation_index = 0
var player_index = 0
var max_round = 3
var round_progression = 0

func _ready() -> void:
	# Init timer
	label = labeled_timer.get_node("Label")
	timer = labeled_timer.get_node("Timer")
	timer.one_shot = true
	timer.wait_time = 3.99
	# Init buttons
	for button in buttons.get_children():
		var buttonAnimation = button.get_node("AnimatedSprite2D")
		buttonAnimation.animation = "loop"
		buttonAnimation.animation_finished.connect(_on_button_pressed.bind(button))
	
	# Init LightCubes
	for cube in light_cubes.get_children():
		cube.animation = "blink"
	
	# Init ProgressionCubes
	for cube in progression_cubes.get_children():
		cube.animation = "light_up"
	
	# Init sequence variables
	sequence.resize(sequence_length)
	
	_init_round()
	_init_progression()


func _init_round() -> void:
	generate_sequence()
	animation_index = -1
	player_index = 0

func _init_progression() -> void:
	round_progression = 0
	for cube in progression_cubes.get_children():
		cube.frame = 0

func _process(delta: float) -> void:
	if door.is_open: return

	# Player pressed the wrong button, wait for error animation to end to start timer
	if animation_index < 0 and !light_cubes.get_child(0).is_playing():
		for cube in progression_cubes.get_children():
			if cube.is_playing(): return
		animation_index = 0
		timer.start()
		return

	if !timer.is_stopped():
		if timer.time_left < 1:
			labeled_timer.visible = false
			return
		labeled_timer.visible = true
		label.text = str("%d" % timer.time_left)
		return

	play_sequence()

func generate_sequence() -> void:
	var rng = RandomNumberGenerator.new()
	for i in sequence_length:
		sequence[i] = rng.randi_range(0, 4)

func play_sequence() -> void:
	if animation_index < 0 or animation_index == sequence_length:
		return

	for light_cube in light_cubes.get_children():
		if light_cube.is_playing():
			return

	light_cubes.get_child(sequence[animation_index]).play()
	animation_index+=1

func _on_button_pressed(button: Area2D) -> void:
	button.pressed = false
	
	if door.is_open: return
	
	# Button disabled when sequence animation playing
	if animation_index != sequence_length: return
	
	for light_cube in light_cubes.get_children():
		if light_cube.is_playing(): return
	 
	if button.get_index() == sequence[player_index]:
		player_index+=1
		if player_index == sequence_length:
			progression_cubes.get_child(round_progression).play()
			round_progression += 1
			if round_progression == max_round:
				door.open()
			else:
				_init_round()
	else:
		# Light all cubes to indicate error
		for light_cube in light_cubes.get_children():
			light_cube.play()
		_init_round()
		_init_progression()
