extends Control

export var char_name = ""
export var expression = ""
export var dialogue = ""
export var answer_01 = ""
export var answer_02 = ""
export var answer_03 = ""
export var sound = ""

signal answer_index

var shido = preload("res://Assets/CharacterSprites/shido.png")

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
	load_character_image(char_name, expression)
	load_sound(sound)
	$Statement.bbcode_text = dialogue
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

func load_character_image(name, expression):
	$CharacterImage.texture = shido
	
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
