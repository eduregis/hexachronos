extends Control

var dialogue = [
	'Uma vez Flamengo, sempre Flamengo,',
	'Flamengo sempre eu hei de ser,',
	'É meu maior prazer, vê-lo brilhar,',
	'Seja na terra, seja no mar,',
	'vencer, vencer, vencer,',
	'uma vez Flamengo, Flamengo até morrer!'
]

var dialogue_index = 0

var finished = false

func _ready():
	load_dialogue()
	
func _process(delta):
	$"next-indicator".visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			load_dialogue()
		else:
			$Tween.stop_all()
			$RichTextLabel.percent_visible = 1
			finished = true
	
func load_dialogue():
	if dialogue_index < dialogue.size():
		finished = false
		$RichTextLabel.bbcode_text = dialogue[dialogue_index]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0 , 1, 1, 
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
	else:
		queue_free()
	dialogue_index += 1


func _on_Tween_tween_completed(object, key):
	finished = true
