extends Control

export var names = []
export var expressions = []
export var dialogue = []
export var sounds = []

var billy_happy = preload("res://Assets/CharacterSprites/Berserker - Billy/Billy_Happy.png")
var billy_sad = preload("res://Assets/CharacterSprites/Berserker - Billy/Billy_Sad.png")
var billy_speechless = preload("res://Assets/CharacterSprites/Berserker - Billy/Billy_Speechless.png")
var billy_tired = preload("res://Assets/CharacterSprites/Berserker - Billy/Billy_Tired.png")
var cap_serious = preload("res://Assets/CharacterSprites/Capitão Salvato/Cap_Serious.png")
var dandara = preload("res://Assets/CharacterSprites/Hammer - Dandara/HAMMER V2.png")
var sam_happy = preload("res://Assets/CharacterSprites/Mecânica - Sam/Sam_Happy.png")
var morya_neutral = preload("res://Assets/CharacterSprites/Rampage - Morya/Morya_Neutral.png")
var thunder_happy = preload("res://Assets/CharacterSprites/Thunder - Borell/Thunder_Happy.png")

var dialogue_index = 0

var finished = false

signal end_of_dialogue

func _ready():
	load_dialogue()
	
func _input(event):
	if Input.is_mouse_button_pressed(1):
		if finished:
			load_dialogue()
		else:
			$Tween.stop_all()
			$TweenCharacter.stop_all()
			$RichTextLabel.percent_visible = 1
			$CharacterImage.modulate = Color(1, 1, 1, 1)
			finished = true
	
func _process(delta):
	$NextDialogueButton.visible = finished
	if dialogue_index < names.size():
		if names[dialogue_index].length() == 0:
			$NameBox.visible = false
			$NameTextLabel.visible = false
		else:
			$NameBox.visible = true
			$NameTextLabel.visible = true
	
func load_dialogue():
	if dialogue_index < dialogue.size():
		finished = false
		load_character_image(expressions[dialogue_index])
		print(expressions[dialogue_index])
		load_sound(sounds[dialogue_index])
		$RichTextLabel.bbcode_text = dialogue[dialogue_index]
		$NameTextLabel.bbcode_text = names[dialogue_index]
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
		"Cap_Happy.png":
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
