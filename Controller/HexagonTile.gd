extends Node2D

export var tile_index = Vector2.ZERO

func _ready():
	$TileHitBox/HitBox.tile_index = tile_index
	$TileHitBox/HitBox.tile_position = position
