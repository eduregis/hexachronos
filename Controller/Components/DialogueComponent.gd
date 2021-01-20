extends Control

signal end_of_dialogue

func _ready():
	$DialogueBox.connect("end_of_dialogue", self, "end_of_dialogue")

func end_of_dialogue():
	emit_signal("end_of_dialogue")

func set_dialogue_code(text_code):
	# fazendo a chamada para o arquivo .JSON
	var file = File.new()
	file.open("res://Database/hexachronosDialogues.json", file.READ)
	var json = file.get_as_text()
	var json_result = JSON.parse(json).result
	file.close()
	
	#passando os valores do dialogo determinado pelo id
	var names = []
	var expressions = []
	var text = []
	var sounds = []
	
	for dialogues in json_result["dialogues"]:
		if dialogues["id"] == text_code:
			for dialogue in dialogues["sequence"]:
				names.append(dialogue["name"])
				expressions.append(dialogue["expression"])
				text.append("(" + dialogue["name"] + ") " + dialogue["text"])
				sounds.append(dialogue["sound"])
			$DialogueBox.dialogue = text
			$DialogueBox.names = names
			$DialogueBox.expressions = expressions
			$DialogueBox.sounds = sounds
