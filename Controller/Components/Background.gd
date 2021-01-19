extends Control

var makoto_angry = preload("res://Assets/CharacterSprites/makoto_angry.png")
var black = preload("res://Assets/Scenarios/scenario_black.png")

var actual_background = "black"


func change_background(background_code):
	if actual_background != background_code:
		var old_background = get_background(actual_background)
		var new_background = get_background(background_code)
		$BackgroundBox/TextureRect.texture = new_background
#		var tween = get_node("Tween")
		
#		tween.interpolate_property(
#			$BackgroundBox/TextureRect, "texture", old_background , new_background, 0.6, 
#			Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
#		)
#		tween.start()
		actual_background = background_code
	else:
		pass

func get_background(background_code):
	var background
	match background_code:
		"black":
			background = black
		"test":
			background = makoto_angry
	return background
	
