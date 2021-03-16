extends Control

var billy_happy = preload("res://Assets/CharacterSprites/Berserker - Billy/Billy_Happy.png")
var billy_sad = preload("res://Assets/CharacterSprites/Berserker - Billy/Billy_Sad.png")
var billy_speechless = preload("res://Assets/CharacterSprites/Berserker - Billy/Billy_Speechless.png")
var billy_tired = preload("res://Assets/CharacterSprites/Berserker - Billy/Billy_Tired.png")
var cap_serious = preload("res://Assets/CharacterSprites/Capitão Salvato/Cap_Serious.png")
var dandara = preload("res://Assets/CharacterSprites/Hammer - Dandara/HAMMER V2.png")
var sam_happy = preload("res://Assets/CharacterSprites/Mecânica - Sam/Sam_Happy.png")
var morya_neutral = preload("res://Assets/CharacterSprites/Rampage - Morya/Morya_Neutral.png")
var thunder_happy = preload("res://Assets/CharacterSprites/Thunder - Borell/Thunder_Happy.png")

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
		"Thunder_Happy.png":
			$CharacterImage.texture = thunder_happy
		"Thunder_Serious.png":
			$CharacterImage.texture = thunder_happy
		"Thunder_Angry.png":
			$CharacterImage.texture = thunder_happy
		"Thunder_Sweet.png":
			$CharacterImage.texture = thunder_happy
		"Thunder_Sigh.png":
			$CharacterImage.texture = thunder_happy
		"Thunder_Hurt.png":
			$CharacterImage.texture = thunder_happy
		"Thunder_Sad.png":
			$CharacterImage.texture = thunder_happy
		"Sam_Serious.png":
			$CharacterImage.texture = sam_happy
		"Sam_Shy.png":
			$CharacterImage.texture = sam_happy
		"Sam_Sad.png":
			$CharacterImage.texture = sam_happy
		"Sam_Surprised.png":
			$CharacterImage.texture = sam_happy
		"Sam_Happy.png":
			$CharacterImage.texture = sam_happy
		"Sam_Defy.png":
			$CharacterImage.texture = sam_happy
		"Sam_Focused.png":
			$CharacterImage.texture = sam_happy
		"Cheeky_Sam.png":
			$CharacterImage.texture = sam_happy
		"Sam_Angry.png":
			$CharacterImage.texture = sam_happy
		"Cap_Happy.png":
			$CharacterImage.texture = cap_serious
		"Cap_Angry.png":
			$CharacterImage.texture = cap_serious
		"Cap_Serious.png":
			$CharacterImage.texture = cap_serious
		"Cap_Surprised.png":
			$CharacterImage.texture = cap_serious
		"Cap_Sad.png":
			$CharacterImage.texture = cap_serious
		"Cap_Shy.png":
			$CharacterImage.texture = cap_serious
		"Cap_Shy_Cough.png":
			$CharacterImage.texture = cap_serious
		"Morya_Serious.png":
			$CharacterImage.texture = morya_neutral
		"Morya_Surprised.png":
			$CharacterImage.texture = morya_neutral
		"Morya_Struggle.png":
			$CharacterImage.texture = morya_neutral
		"Morya_Sad.png":
			$CharacterImage.texture = morya_neutral
		"Morya_Sigh.png":
			$CharacterImage.texture = morya_neutral
		"Hammer_Serious.png":
			$CharacterImage.texture = dandara
		"Hammer_Angry.png":
			$CharacterImage.texture = dandara
		"Hammer_Happy.png":
			$CharacterImage.texture = dandara
		"Hammer_Sweet.png":
			$CharacterImage.texture = dandara
		"Hammer_Surprised.png":
			$CharacterImage.texture = dandara
		"Hammer_Smile.png":
			$CharacterImage.texture = dandara
		"Billy_Blank.png":
			$CharacterImage.texture = billy_speechless
		"Billy_Speechless.png":
			$CharacterImage.texture = billy_speechless
		"Billy_Tired.png":
			$CharacterImage.texture = billy_tired
		"Billy_Happy.png":
			$CharacterImage.texture = billy_happy
		"Billy_Sad.png":
			$CharacterImage.texture = billy_sad
		"Billy_Surprised.png":
			$CharacterImage.texture = billy_speechless
		"Billy_Broke.png":
			$CharacterImage.texture = billy_speechless
		"Billy_Struggle.png":
			$CharacterImage.texture = billy_speechless
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
