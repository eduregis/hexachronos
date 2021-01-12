extends Node2D

var DialogueBox = preload("res://View/DialogueBox.tscn")

func _ready():
	var window = get_viewport_rect().size
	var dialogueBox = DialogueBox.instance()
	dialogueBox.set_text(["A","B"])
	dialogueBox.set_position(Vector2(window.x/2, window.y))
	self.add_child(dialogueBox)
