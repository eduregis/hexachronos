extends Node2D

export var index = Vector2.ZERO
export var character_info = {}
export var team = ""

func move_to(tile_position):
	$Tween.interpolate_property(
			self, "position", position , tile_position, 1, 
			Tween.TRANS_SINE, Tween.EASE_IN_OUT
		)
	$Tween.start()
#	position = tile_position
