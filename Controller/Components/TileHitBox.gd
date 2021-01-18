extends CollisionPolygon2D

export var tile_index = Vector2.ZERO
export var tile_position = Vector2.ZERO

signal path_move

func _on_TileHitBox_input_event(viewport, event, shape_idx):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		emit_signal("path_move")
