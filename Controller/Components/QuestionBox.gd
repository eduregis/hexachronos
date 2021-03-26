extends Control

var billy_broke = preload("res://Assets/CharacterSprites/Berserker - Billy/Billy_Broke.png")
var billy_confused = preload("res://Assets/CharacterSprites/Berserker - Billy/Billy_Confused.png")
var billy_happy = preload("res://Assets/CharacterSprites/Berserker - Billy/Billy_Happy.png")
var billy_sad = preload("res://Assets/CharacterSprites/Berserker - Billy/Billy_Sad.png")
var billy_serious = preload("res://Assets/CharacterSprites/Berserker - Billy/Billy_Serious.png")
var billy_speechless = preload("res://Assets/CharacterSprites/Berserker - Billy/Billy_Speechless.png")
var billy_struggle = preload("res://Assets/CharacterSprites/Berserker - Billy/Billy_Struggle.png")
var billy_surprised = preload("res://Assets/CharacterSprites/Berserker - Billy/Billy_Surprised.png")
var billy_tired = preload("res://Assets/CharacterSprites/Berserker - Billy/Billy_Tired.png")

var cap_angry = preload("res://Assets/CharacterSprites/Capitão Salvato/Cap_Angry.png")
var cap_happy = preload("res://Assets/CharacterSprites/Capitão Salvato/Cap_Happy.png")
var cap_sad = preload("res://Assets/CharacterSprites/Capitão Salvato/Cap_Sad.png")
var cap_serious = preload("res://Assets/CharacterSprites/Capitão Salvato/Cap_Serious.png")
var cap_shy = preload("res://Assets/CharacterSprites/Capitão Salvato/Cap_Shy.png")
var cap_surprised = preload("res://Assets/CharacterSprites/Capitão Salvato/Cap_Surprised.png")
var cap_sweet = preload("res://Assets/CharacterSprites/Capitão Salvato/Cap_Sweet.png")

var dandara_angry = preload("res://Assets/CharacterSprites/Hammer - Dandara/Hammer_Angry.png")
var dandara_happy = preload("res://Assets/CharacterSprites/Hammer - Dandara/Hammer_Happy.png")
var dandara_serious = preload("res://Assets/CharacterSprites/Hammer - Dandara/Hammer_Serious.png")
var dandara_smile = preload("res://Assets/CharacterSprites/Hammer - Dandara/Hammer_Smile.png")
var dandara_surprised = preload("res://Assets/CharacterSprites/Hammer - Dandara/Hammer_Surprised.png")
var dandara_sweet = preload("res://Assets/CharacterSprites/Hammer - Dandara/Hammer_Sweet.png")

var sam_angry = preload("res://Assets/CharacterSprites/Mecânica - Sam/Sam_Angry.png")
var sam_defy = preload("res://Assets/CharacterSprites/Mecânica - Sam/Sam_Defy.png")
var sam_happy = preload("res://Assets/CharacterSprites/Mecânica - Sam/Sam_Happy.png")
var sam_shy = preload("res://Assets/CharacterSprites/Mecânica - Sam/Sam_Shy.png")
var sam_suprised = preload("res://Assets/CharacterSprites/Mecânica - Sam/Sam_Surprised.png")

var thunder_angry = preload("res://Assets/CharacterSprites/Thunder - Borell/Thunder_Angry.png")
var thunder_happy = preload("res://Assets/CharacterSprites/Thunder - Borell/Thunder_Happy.png")
var thunder_hurt = preload("res://Assets/CharacterSprites/Thunder - Borell/Thunder_Hurt.png")
var thunder_sad = preload("res://Assets/CharacterSprites/Thunder - Borell/Thunder_Sad.png")
var thunder_serious = preload("res://Assets/CharacterSprites/Thunder - Borell/Thunder_Serious.png")
var thunder_sigh = preload("res://Assets/CharacterSprites/Thunder - Borell/Thunder_Sigh.png")
var thunder_sweet = preload("res://Assets/CharacterSprites/Thunder - Borell/Thunder_Sweet.png")

var morya_neutral = preload("res://Assets/CharacterSprites/Rampage - Morya/Morya_Neutral.png")

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
			$CharacterImage.texture = billy_speechless
		"Billy_Confused.png":
			$CharacterImage.texture = billy_confused
		"Billy_Happy.png":
			$CharacterImage.texture = billy_happy
		"Billy_Sad.png":
			$CharacterImage.texture = billy_sad
		"Billy_Serious.png":
			$CharacterImage.texture = billy_serious
		"Billy_Speechless.png":
			$CharacterImage.texture = billy_speechless
		"Billy_Struggle.png":
			$CharacterImage.texture = billy_struggle
		"Billy_Surprised.png":
			$CharacterImage.texture = billy_surprised
		"Billy_Blank.png":
			$CharacterImage.texture = billy_speechless
		"Billy_Tired.png":
			$CharacterImage.texture = billy_tired
		"Cap_Angry.png":
			$CharacterImage.texture = cap_angry
		"Cap_Happy.png":
			$CharacterImage.texture = cap_happy
		"Cap_Sad.png":
			$CharacterImage.texture = cap_sad
		"Cap_Serious.png":
			$CharacterImage.texture = cap_serious
		"Cap_Shy.png":
			$CharacterImage.texture = cap_shy
		"Cap_Surprised.png":
			$CharacterImage.texture = cap_surprised
		"Cap_Shy_Cough.png":
			$CharacterImage.texture = cap_shy
		"Cap_Sweet.png":
			$CharacterImage.texture = cap_sweet
		"Hammer_Angry.png":
			$CharacterImage.texture = dandara_angry
		"Hammer_Happy.png":
			$CharacterImage.texture = dandara_happy
		"Hammer_Serious.png":
			$CharacterImage.texture = dandara_serious
		"Hammer_Smile.png":
			$CharacterImage.texture = dandara_smile
		"Hammer_Surprised.png":
			$CharacterImage.texture = dandara_surprised
		"Hammer_Sweet.png":
			$CharacterImage.texture = dandara_sweet
		"Sam_Angry.png":
			$CharacterImage.texture = sam_angry
		"Sam_Defy.png":
			$CharacterImage.texture = sam_defy
		"Sam_Happy.png":
			$CharacterImage.texture = sam_happy
		"Sam_Shy.png":
			$CharacterImage.texture = sam_shy
		"Sam_Serious.png":
			$CharacterImage.texture = sam_angry
		"Sam_Sad.png":
			$CharacterImage.texture = sam_angry
		"Sam_Surprised.png":
			$CharacterImage.texture = sam_suprised
		"Sam_Focused.png":
			$CharacterImage.texture = sam_angry
		"Cheeky_Sam.png":
			$CharacterImage.texture = sam_happy
		"Thunder_Angry.png":
			$CharacterImage.texture = thunder_angry
		"Thunder_Happy.png":
			$CharacterImage.texture = thunder_happy
		"Thunder_Hurt.png":
			$CharacterImage.texture = thunder_hurt
		"Thunder_Sad.png":
			$CharacterImage.texture = thunder_sad
		"Thunder_Serious.png":
			$CharacterImage.texture = thunder_serious
		"Thunder_Sigh.png":
			$CharacterImage.texture = thunder_sigh
		"Thunder_Sweet.png":
			$CharacterImage.texture = thunder_sweet
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
