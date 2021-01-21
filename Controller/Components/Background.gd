extends Control

var test = preload("res://Assets/Scenarios/test_tela.png")
var black = preload("res://Assets/Scenarios/scenario_black.png")

var actual_background = ""
var is_first_background_setted = true
var actual_index = 1

func _ready():
	$BackgroundBox/Background1.modulate = Color(1,1,1,1)
	$BackgroundBox/Background2.modulate = Color(1,1,1,0)

func change_background(background_code):
	if actual_background != background_code:
		var old_background = get_background(actual_background)
		var new_background = get_background(background_code)
		if actual_index == 1:
			$BackgroundBox/Background1.texture = new_background
			$Tween.interpolate_property(
				$BackgroundBox/Background1, "modulate", 
				Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.4, 
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
			)
			$Tween.interpolate_property(
				$BackgroundBox/Background2, "modulate", 
				Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.4, 
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
			)
			$Tween.start()
			actual_index = 2
		elif actual_index == 2:
			$BackgroundBox/Background2.texture = new_background
			$Tween.interpolate_property(
				$BackgroundBox/Background2, "modulate", 
				Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.4, 
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
			)
			$Tween.interpolate_property(
				$BackgroundBox/Background1, "modulate", 
				Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.4, 
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
			)
			$Tween.start()
			actual_index = 1
		actual_background = background_code
		if is_first_background_setted:
			is_first_background_setted = false
	else:
		pass

func get_background(background_code):
	var background
	match background_code:
		"black":
			background = black
		"test":
			background = test
	return background
	
