extends Node2D

var DialogueComponent = preload("res://View/Components/DialogueComponent.tscn")
var QuestionBox = preload("res://View/Components/QuestionBox.tscn")
var Background = preload("res://View/Components/Background.tscn")
var Transition = preload("res://View/Components/Transition.tscn")

var background
var transition

var answer_index = 0

signal dialogue_ended
signal answer_index
	
func load_dialogue(text_code):
	var window = get_viewport_rect().size
	var dialogueComponent = DialogueComponent.instance()
	dialogueComponent.set_dialogue_code(text_code)
	dialogueComponent.set_position(Vector2(window.x/2, window.y))
	dialogueComponent.connect("end_of_dialogue", self, "dialogue_ended")
	self.add_child(dialogueComponent)

func dialogue_ended():
	emit_signal("dialogue_ended")

func load_question(text_code):
	var window = get_viewport_rect().size
	var questionBox = QuestionBox.instance()
	questionBox.set_question_code(text_code)
	questionBox.set_position(Vector2(window.x/2, window.y))
	questionBox.connect("answer_index", self, "end_of_question")
	self.add_child(questionBox)
	
func end_of_question(index):
	answer_index = index
	emit_signal("answer_index")
	

func load_background(background_code):
	if background == null:
		var window = get_viewport_rect().size
		background = Background.instance()
		background.set_position(Vector2(window.x/2, window.y))
		background.change_background(background_code)
		self.add_child(background)
	else:
		background.change_background(background_code)

func load_quick_transition(quick_transition):
	var window = get_viewport_rect().size
	transition = Transition.instance()
	transition.set_position(Vector2(window.x/2, window.y))
	transition.quick_transition = quick_transition
	self.add_child(transition)

func dismiss_transition():
	transition.dismiss_transition()
