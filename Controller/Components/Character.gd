extends Node2D

export var index = Vector2.ZERO
export var character_info = {}
export var team = ""

func move_to(tile_position):
	var tween1 = get_node("Tween")
	var tween2 = get_node("Tween")
	tween1.interpolate_property(
			self, "position:x", position.x , tile_position.x, 0.6, 
			Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
		)
	tween1.start()
	var yAnchor = position.y - 30
	tween2.interpolate_property(
			self, "position:y", position.y , yAnchor, 0.3, 
			Tween.TRANS_SINE, Tween.EASE_OUT
		)
	tween2.start()
	yield(tween2, "tween_completed")
	tween2.interpolate_property(
			self, "position:y", yAnchor, tile_position.y, 0.3, 
			Tween.TRANS_SINE, Tween.EASE_IN
		)
	tween2.start()
#	position = tile_position
