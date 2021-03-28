extends Control



export var char_name = ""
export var expression = ""
export var dialogue = ""
export var answer_01 = ""
export var answer_02 = ""
export var answer_03 = ""
export var sound = ""

signal answer_index

var dialogue_index = 0

var finished = false

func _ready():
	load_question()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if !finished:
			$Tween.stop_all()
			$Statement.percent_visible = 1
			$CharacterImage.modulate = Color(1, 1, 1, 1)
			$Answer1.modulate = Color(1, 1, 1, 1)
			$Answer2.modulate = Color(1, 1, 1, 1)
			$Answer3.modulate = Color(1, 1, 1, 1)
			finished = true
	
	
func load_question():
	fade_in_character()
	load_character_image(expression)
	load_sound(sound)
	$Statement.bbcode_text = dialogue
	$NameTextLabel.bbcode_text = "[center]" + String(char_name) + "[/center]"
	$Answer1.text = answer_01
	$Answer2.text = answer_02
	$Answer3.text = answer_03
	$Statement.percent_visible = 0
	$CharacterImage.modulate = Color(1, 1, 1, 0)
	$Answer1.modulate = Color(1, 1, 1, 0)
	$Answer2.modulate = Color(1, 1, 1, 0)
	$Answer3.modulate = Color(1, 1, 1, 0)
	$Tween.interpolate_property(
		$Statement, "percent_visible", 0 , 1, 1, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	$Tween.start()
	yield($Tween, "tween_completed")
	fade_in_answer()
	$Tween.start()

func fade_in_answer():
	$Tween.interpolate_property(
		$Answer1, "modulate", Color(1, 1, 1, 0) , Color(1, 1, 1, 1), 0.4, 
		Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	yield(get_tree().create_timer(0.2), "timeout")
	$Tween.interpolate_property(
		$Answer2, "modulate", Color(1, 1, 1, 0) , Color(1, 1, 1, 1), 0.4, 
		Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	yield(get_tree().create_timer(0.2), "timeout")
	if answer_03 != "":
		$Tween.interpolate_property(
			$Answer3, "modulate", Color(1, 1, 1, 0) , Color(1, 1, 1, 1), 0.4, 
			Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
		)
	else:
		$Answer3.disabled = true
	
func fade_in_character():
	$CharacterImage.modulate = Color(1, 1, 1, 0)
	$Tween.interpolate_property(
		$CharacterImage, "modulate", 
		Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.3, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)

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

func _on_Answer1_pressed():
	emit_signal("answer_index", 1)

func _on_Answer2_pressed():
	emit_signal("answer_index", 2)

func _on_Answer3_pressed():
	emit_signal("answer_index", 3)
