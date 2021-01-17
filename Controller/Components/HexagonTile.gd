extends Node2D

export var tile_index = Vector2.ZERO
var occupied = false
var path = false

func _ready():
	$TileHitBox/HitBox.tile_index = tile_index
	$TileHitBox/HitBox.tile_position = position

func char_tile():
	$Sprite.modulate = Color(0.3, 0.3, 0.3)
	occupied = true

func path_tile():
	$Sprite.modulate = Color(0.7, 0.7, 0.7)
	path = true

func _on_TileHitBox_mouse_entered():
	if !occupied:
		$Sprite.modulate = Color(0.5, 0.5, 0.5)


func _on_TileHitBox_mouse_exited():
	if !occupied:
		$Sprite.modulate = Color(1, 1, 1)
	if path:
		$Sprite.modulate = Color(0.7, 0.7, 0.7)
