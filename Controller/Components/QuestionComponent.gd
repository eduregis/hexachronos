extends Control

signal answer_index

func _ready():
	self.modulate = Color(1, 1, 1, 0)
	$QuestionBox.connect("answer_index", self, "answer_index")
	$QuestionTween.interpolate_property(
		self, "modulate", 
		Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.4, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	$QuestionTween.start()

func answer_index(index):
	emit_signal("answer_index", index)
	$QuestionTween.interpolate_property(
		self, "modulate", 
		Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.4, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	$QuestionTween.start()
	yield($QuestionTween, "tween_completed")
	queue_free()

func set_question_code(text_code):
	# fazendo a chamada para o arquivo .JSON
	var file = File.new()
	file.open("res://Database/hexachronosQuestions.json", file.READ)
	var json = file.get_as_text()
	var json_result = JSON.parse(json).result
	file.close()
	
	#passando os valores do dialogo determinado pelo id
	for questions in json_result["questions"]:
		if questions["id"] == text_code:
			var question = questions["question"]
			$QuestionBox.char_name = question["name"]
			$QuestionBox.expression = question["expression"]
			$QuestionBox.dialogue = question["statement"]
			$QuestionBox.answer_01 = question["answer_01"]
			$QuestionBox.answer_02 = question["answer_02"]
			$QuestionBox.answer_03 = question["answer_03"]
			$QuestionBox.sound = question["sound"]
	
