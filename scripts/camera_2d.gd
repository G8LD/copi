extends Camera2D

@export var tilemap: TileMapLayer

func _ready() -> void:
	await get_tree().process_frame
	
	setup_camera_limits()

func setup_camera_limits() -> void:
	if not tilemap:
		return
	
	var used_rect: Rect2i = tilemap.get_used_rect()
	var tile_size := tilemap.tile_set.get_tile_size()

	limit_left = used_rect.position.x * tile_size.x
	limit_top = used_rect.position.y * tile_size.y
	limit_right = (used_rect.position.x + used_rect.size.x) * tile_size.x
	limit_bottom = (used_rect.position.y + used_rect.size.y) * tile_size.y
