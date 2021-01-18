extends Node2D

export var tile_index = Vector2.ZERO
var occupied = false
var path = false

signal path_move_to

func _ready():
	$TileHitBox/HitBox.tile_index = tile_index
	$TileHitBox/HitBox.tile_position = position
	$TileHitBox/HitBox.connect("path_move", self, "path_move_to")

func path_move_to():
	emit_signal("path_move_to", tile_index, position)
	
func remove_path():
	path = false
	if !occupied:
		$Sprite.modulate = Color(1, 1, 1)

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


func _on_TileHitBox_input_event(viewport, event, shape_idx):
	print(tile_index)
