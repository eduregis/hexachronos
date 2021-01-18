extends Node2D

export var tile_index = Vector2.ZERO
var occupied = false
var path = false

signal path_move_to

func _ready():
	$Sprite.scale = Vector2.ZERO
	$TileHitBox/HitBox.tile_index = tile_index
	$TileHitBox/HitBox.tile_position = position
	$TileHitBox/HitBox.connect("path_move", self, "path_move_to")
	yield(get_tree().create_timer((tile_index.x + tile_index.y) * 0.1), "timeout")
	$Tween.interpolate_property(
		$Sprite, "scale", Vector2.ZERO, Vector2(1, 1), 0.4, 
		Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	$Tween.start()

func path_move_to():
	emit_signal("path_move_to", tile_index, position)
	
func remove_path():
	path = false
	if !occupied:
		$Sprite.modulate = Color(1, 1, 1)

func char_tile():
	yield(get_tree().create_timer((tile_index.x + tile_index.y) * 0.1), "timeout")
	$Tween.interpolate_property(
			$Sprite, "modulate", Color(1, 1, 1) , Color(0.3, 0.3, 0.3), 0.4, 
			Tween.TRANS_SINE, Tween.TRANS_LINEAR
		)
	$Tween.start()
	occupied = true

func path_tile(path_index):
	if !occupied:
		yield(get_tree().create_timer(path_index * 0.02), "timeout")
		$Tween.interpolate_property(
			$Sprite, "modulate", Color(1, 1, 1) , Color(0.7, 0.7, 0.7), 0.4, 
			Tween.TRANS_SINE, Tween.TRANS_LINEAR
		)
		$Tween.start()
	path = true

func _on_TileHitBox_mouse_entered():
	if !occupied:
		$Sprite.modulate = Color(0.5, 0.5, 0.5)


func _on_TileHitBox_mouse_exited():
	if !occupied:
		$Sprite.modulate = Color(1, 1, 1)
		if path:
			$Sprite.modulate = Color(0.7, 0.7, 0.7)
