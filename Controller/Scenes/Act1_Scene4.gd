extends "res://Controller/Scenes/SceneWithSkills.gd"

func _ready():
	load_dialogue("0037")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(1.0), "timeout")
	load_question("0010")
	yield(self, "answer_index")
	if answer_index == 1:
		load_dialogue("0038")
	elif answer_index == 2:
		load_dialogue("0039")
	elif answer_index == 3:
		load_dialogue("0040")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(1.0), "timeout")
	load_dialogue("0041")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(1.0), "timeout")
	load_dialogue("0042")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(1.0), "timeout")
	load_question("0011")
	yield(self, "answer_index")
	if answer_index == 1:
		load_dialogue("0043")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
		fight_without_billy()
	elif answer_index == 2:
		other_way()

func fight_without_billy():
	load_quick_transition(false)
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().change_scene("res://View/Scenes/Act1_Battle4_1.tscn")
	
func fight_with_billy():
	load_quick_transition(false)
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().change_scene("res://View/Scenes/Act1_Battle4_2.tscn")

func other_way():
	load_dialogue("0045")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(1.0), "timeout")
	load_question("0012")
	yield(self, "answer_index")
	if answer_index == 1:
		load_dialogue("0046")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
		fight_with_billy()
	elif answer_index == 2:
		load_dialogue("0048")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
		fight_without_billy()
