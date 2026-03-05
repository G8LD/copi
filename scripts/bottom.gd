extends Area2D

@onready var player: CharacterBody2D = %Player
@export var tilemap: TileMapLayer

func _on_body_entered(body: Node2D) -> void:
	var used_rect: Rect2i = tilemap.get_used_rect()
	var tile_size := tilemap.tile_set.get_tile_size()
	
	player.set_global_position(Vector2(player.last_position_on_floor.x, used_rect.position.y * tile_size.y))
	player.velocity = Vector2(0,0)
