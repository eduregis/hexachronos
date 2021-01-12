extends Control

export var names = []
export var expressions = []
export var dialogue = []

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
	
func test():
	print("aaa")
	
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
