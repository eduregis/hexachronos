extends Control

export var names = []
export var expressions = []
export var dialogue = []
export var sounds = []




var button = preload("res://Assets/TextBox/Button.png")
var button_hover = preload("res://Assets/TextBox/Button-Hover.png")
var button_clicked = preload("res://Assets/TextBox/Button-Clicked.png")

var dialogue_index = 0

var finished = false

signal end_of_dialogue

func _ready():
	load_dialogue()
	
func _input(event):
	pass
#	if Input.is_mouse_button_pressed(1):
#		if finished:
#			load_dialogue()
#		else:
#			$Tween.stop_all()
#			$TweenCharacter.stop_all()
#			$RichTextLabel.percent_visible = 1
#			$CharacterImage.modulate = Color(1, 1, 1, 1)
#			finished = true
	
func _process(delta):
#	if dialogue_index < names.size():
#		if names[dialogue_index].length() == 0:
#			$NameBox.visible = false
#			$NameTextLabel.visible = false
#		else:
#			$NameBox.visible = true
#			$NameTextLabel.visible = true
	pass
	
func load_dialogue():
	if dialogue_index < dialogue.size():
		finished = false
		load_character_image(expressions[dialogue_index])
		print(expressions[dialogue_index])
		load_sound(sounds[dialogue_index])
		$RichTextLabel.bbcode_text = dialogue[dialogue_index]
		change_text_color()
		$NameTextLabel.bbcode_text = "[center]" + String(names[dialogue_index]) + "[/center]"
		$RichTextLabel.percent_visible = 0
		var dialogue_length = dialogue[dialogue_index].length()
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0 , 1, dialogue_length * 0.02, 
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		if dialogue_index > 0:
			if names[dialogue_index] != names[dialogue_index - 1]:
				fade_in_character()
		else:
			fade_in_character()
		
		$Tween.start()
	else:
		emit_signal("end_of_dialogue")
	dialogue_index += 1
	
func change_text_color():
	var thought = $RichTextLabel.bbcode_text
	if thought.length() > 0:
		if thought[0] == "|" && thought[thought.length() - 1] == "|":
			thought.erase(0, 1)
			thought.erase(thought.length() - 1, 1)
			$RichTextLabel.bbcode_text = thought
			$RichTextLabel.set("custom_colors/default_color", Color(1,1,0,1))
		else:
			$RichTextLabel.set("custom_colors/default_color", Color(1,1,1,1))
		
		
func fade_in_character():
	$CharacterImage.modulate = Color(1, 1, 1, 0)
	$TweenCharacter.interpolate_property(
		$CharacterImage, "modulate", 
		Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.3, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	$TweenCharacter.start()
	
func load_character_image(expression):
	match expression:
		"Billy_Broke.png":
			$CharacterImage.texture = Global.billy_speechless
		"Billy_Confused.png":
			$CharacterImage.texture = Global.billy_confused
		"Billy_Happy.png":
			$CharacterImage.texture = Global.billy_happy
		"Billy_Sad.png":
			$CharacterImage.texture = Global.billy_sad
		"Billy_Serious.png":
			$CharacterImage.texture = Global.billy_serious
		"Billy_Speechless.png":
			$CharacterImage.texture = Global.billy_speechless
		"Billy_Struggle.png":
			$CharacterImage.texture = Global.billy_struggle
		"Billy_Surprised.png":
			$CharacterImage.texture = Global.billy_surprised
		"Billy_Blank.png":
			$CharacterImage.texture = Global.billy_speechless
		"Billy_Tired.png":
			$CharacterImage.texture = Global.billy_tired
		"Cap_Angry.png":
			$CharacterImage.texture = Global.cap_angry
		"Cap_Happy.png":
			$CharacterImage.texture = Global.cap_happy
		"Cap_Sad.png":
			$CharacterImage.texture = Global.cap_sad
		"Cap_Serious.png":
			$CharacterImage.texture = Global.cap_serious
		"Cap_Shy.png":
			$CharacterImage.texture = Global.cap_shy
		"Cap_Surprised.png":
			$CharacterImage.texture = Global.cap_surprised
		"Cap_Shy_Cough.png":
			$CharacterImage.texture = Global.cap_shy
		"Cap_Sweet.png":
			$CharacterImage.texture = Global.cap_sweet
		"Hammer_Angry.png":
			$CharacterImage.texture = Global.dandara_angry
		"Hammer_Happy.png":
			$CharacterImage.texture = Global.dandara_happy
		"Hammer_Serious.png":
			$CharacterImage.texture = Global.dandara_serious
		"Hammer_Smile.png":
			$CharacterImage.texture = Global.dandara_smile
		"Hammer_Surprised.png":
			$CharacterImage.texture = Global.dandara_surprised
		"Hammer_Sweet.png":
			$CharacterImage.texture = Global.dandara_sweet
		"Sam_Angry.png":
			$CharacterImage.texture = Global.sam_angry
		"Sam_Defy.png":
			$CharacterImage.texture = Global.sam_defy
		"Sam_Happy.png":
			$CharacterImage.texture = Global.sam_happy
		"Sam_Shy.png":
			$CharacterImage.texture = Global.sam_shy
		"Sam_Serious.png":
			$CharacterImage.texture = Global.sam_angry
		"Sam_Sad.png":
			$CharacterImage.texture = Global.sam_angry
		"Sam_Surprised.png":
			$CharacterImage.texture = Global.sam_suprised
		"Sam_Focused.png":
			$CharacterImage.texture = Global.sam_angry
		"Cheeky_Sam.png":
			$CharacterImage.texture = Global.sam_happy
		"Thunder_Angry.png":
			$CharacterImage.texture = Global.thunder_angry
		"Thunder_Happy.png":
			$CharacterImage.texture = Global.thunder_happy
		"Thunder_Hurt.png":
			$CharacterImage.texture = Global.thunder_hurt
		"Thunder_Sad.png":
			$CharacterImage.texture = Global.thunder_sad
		"Thunder_Serious.png":
			$CharacterImage.texture = Global.thunder_serious
		"Thunder_Sigh.png":
			$CharacterImage.texture = Global.thunder_sigh
		"Thunder_Sweet.png":
			$CharacterImage.texture = Global.thunder_sweet
		"Morya_Serious.png":
			$CharacterImage.texture = Global.morya_neutral
		"Morya_Surprised.png":
			$CharacterImage.texture = Global.morya_neutral
		"Morya_Struggle.png":
			$CharacterImage.texture = Global.morya_neutral
		"Morya_Sad.png":
			$CharacterImage.texture = Global.morya_neutral
		"Morya_Sigh.png":
			$CharacterImage.texture = Global.morya_neutral
		_:
			$CharacterImage.texture = null
		

func load_sound(sound):
	match sound:
		"robot":
			$AudioStreamPlayer.stream = load("res://SoundEffects/robot_move.wav")
			$AudioStreamPlayer.play()

func _on_Tween_tween_completed(object, key):
	finished = true

func _on_Button_pressed():
	$Button.icon = button_clicked
	if finished:
		load_dialogue()
	else:
		$Tween.stop_all()
		$TweenCharacter.stop_all()
		$RichTextLabel.percent_visible = 1
		$CharacterImage.modulate = Color(1, 1, 1, 1)
		finished = true
	yield(get_tree().create_timer(0.1), "timeout")
	$Button.icon = button

func _on_Button_mouse_entered():
	$Button.icon = button_hover

func _on_Button_mouse_exited():
	$Button.icon = button
