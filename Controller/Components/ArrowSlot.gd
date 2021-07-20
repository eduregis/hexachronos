extends Node2D

var arrow_up = preload("res://Assets/HUD/AttackMenu/arrowUp.png")
var arrow_left = preload("res://Assets/HUD/AttackMenu/arrowLeft.png")
var arrow_right = preload("res://Assets/HUD/AttackMenu/arrowRight.png")
var arrow_down = preload("res://Assets/HUD/AttackMenu/arrowDown.png")

func arrowTo(direction):
	match direction:
		"up":
			$Arrow.texture = arrow_up
			toggleAnimate()
		"left":
			$Arrow.texture = arrow_left
			toggleAnimate()
		"right":
			$Arrow.texture = arrow_right
			toggleAnimate()
		"down":
			$Arrow.texture = arrow_down
			toggleAnimate()
		_:
			dismissAnimate()
	
	
func toggleAnimate():
	$Arrow.modulate = Color(1,1,1,0)
	var tween = get_node("Tween")
	tween.interpolate_property(
		$Arrow, "modulate", Color(1, 1, 1, 0) , Color(1, 1, 1, 1), 0.2, 
		Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	tween.interpolate_property(
		$Arrow, "scale", Vector2(2, 2), Vector2(1, 1), 0.2, 
		Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT
	)
	tween.start()
	
func dismissAnimate():
	var tween = get_node("Tween")
	tween.interpolate_property(
		$Arrow, "modulate", Color(1, 1, 1, 1) , Color(1, 1, 1, 0), 0.2, 
		Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	tween.interpolate_property(
		$Arrow, "scale", Vector2(1, 1), Vector2(2, 2), 0.2, 
		Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT
	)
	tween.start()
	yield(tween, "tween_completed")
	$Arrow.texture = null
