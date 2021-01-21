extends Control

export var names = []
export var expressions = []
export var dialogue = []
export var sounds = []

var makoto_angry = preload("res://Assets/CharacterSprites/makoto_angry.png")
var makoto_surprised = preload("res://Assets/CharacterSprites/makoto_surprised.png")
var makoto_neutral = preload("res://Assets/CharacterSprites/makoto_neutral.png")
var ryuji_happy = preload("res://Assets/CharacterSprites/ryuji_happy.png")
var ryuji_surprised = preload("res://Assets/CharacterSprites/ryuji_surprised.png")
var ryuji_sad = preload("res://Assets/CharacterSprites/ryuji_sad.png")

var dialogue_index = 0

var finished = false

func _ready():
	load_dialogue()
	
func _process(delta):
	$"next-indicator".visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		print(finished)
		if finished:
			load_dialogue()
		else:
			$Tween.stop_all()
			$TweenCharacter.stop_all()
			$RichTextLabel.percent_visible = 1
			$CharacterImage.modulate = Color(1, 1, 1, 1)
			finished = true
	
func load_dialogue():
	if dialogue_index < dialogue.size():
		finished = false
		load_character_image(names[dialogue_index], expressions[dialogue_index])
		load_sound(sounds[dialogue_index])
		$RichTextLabel.bbcode_text = dialogue[dialogue_index]
		$RichTextLabel.percent_visible = 0
		
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0 , 1, 1, 
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		if dialogue_index > 0:
			if names[dialogue_index] != names[dialogue_index - 1]:
				fade_in_character()
		else:
			fade_in_character()
		
		$Tween.start()
	else:
		queue_free()
	dialogue_index += 1
	
func fade_in_character():
	$CharacterImage.modulate = Color(1, 1, 1, 0)
	$TweenCharacter.interpolate_property(
		$CharacterImage, "modulate", 
		Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.3, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	$TweenCharacter.start()
	
func load_character_image(name, expression):
	match name:
		"Makoto":
			match expression:
				"surprised":
					$CharacterImage.texture = makoto_surprised
				"neutral":
					$CharacterImage.texture = makoto_neutral
				"angry":
					$CharacterImage.texture = makoto_angry
		"Ryuji":
			match expression:
				"surprised":
					$CharacterImage.texture = ryuji_surprised
				"happy":
					$CharacterImage.texture = ryuji_happy
				"sad":
					$CharacterImage.texture = ryuji_sad

func load_sound(sound):
	match sound:
		"robot":
			$AudioStreamPlayer.stream = load("res://SoundEffects/robot_move.wav")
			$AudioStreamPlayer.play()

func _on_Tween_tween_completed(object, key):
	finished = true
