extends CharacterBody2D

@onready var player: CharacterBody2D = $"."
@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"


const SPEED = 200.0
const JUMP_VELOCITY = -400.0

var has_key = false
var last_position_on_floor: Vector2

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		# Set the last position of the user on the tile map layer
		var floor_position = Vector2(player.position.x, player.position.y + tile_map_layer.tile_set.get_tile_size().y)
		var player_tile_map_position = tile_map_layer.local_to_map(floor_position)
		var tile = tile_map_layer.get_cell_tile_data(player_tile_map_position)
		if tile:
			last_position_on_floor = tile_map_layer.map_to_local(player_tile_map_position)

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
