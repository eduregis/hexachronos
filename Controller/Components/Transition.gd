extends Control

var black = preload("res://Assets/Scenarios/scenario_black.png")

var actual_background = "black"
var quick_transition = false

signal end_of_transition

func _ready():
	self.modulate = Color(1, 1, 1, 0)
	$Tween.interpolate_property(
		self, "modulate", 
		Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.4, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	$Tween.start()
	if quick_transition:
		yield($Tween, "tween_completed")
		dismiss_transition()


func change_transition(background_code):
	if actual_background != background_code:
		var old_background = get_transition(actual_background)
		var new_background = get_transition(background_code)
		$BackgroundBox/TextureRect.texture = new_background
		actual_background = background_code
	else:
		pass

func get_transition(background_code):
	var background
	match background_code:
		"black":
			background = black
	return background
	
func dismiss_transition():
	$Tween.interpolate_property(
		self, "modulate", 
		Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.4, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	$Tween.start()
	yield($Tween, "tween_completed")
	emit_signal("end_of_transition")
	queue_free()
