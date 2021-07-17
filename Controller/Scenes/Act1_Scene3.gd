extends "res://Controller/Scenes/BasicScene.gd"

func _ready():
	load_dialogue("00010")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(1.0), "timeout")
	load_dialogue("00011")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(1.0), "timeout")
	load_dialogue("00012")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(0.5), "timeout")
	load_question("0001")
	yield(self, "answer_index")
	if answer_index == 1:
		load_dialogue("00013")
	elif answer_index == 2:
		load_dialogue("00014")
	elif answer_index == 3:
		load_dialogue("00015")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(1.0), "timeout")
	load_dialogue("00016")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(0.5), "timeout")
	load_question("0002")
	yield(self, "answer_index")
	if answer_index == 1:
		load_dialogue("00017")
	elif answer_index == 2:
		load_dialogue("00018")
	elif answer_index == 3:
		load_dialogue("00019")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(1.0), "timeout")
	load_dialogue("00020")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(0.5), "timeout")
	load_question("0003")
	yield(self, "answer_index")
	if answer_index == 2:
		next_day()
	elif answer_index == 1:
		load_dialogue("00021")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(0.5), "timeout")
		load_question("0004")
		yield(self, "answer_index")
		if answer_index == 1:
			load_dialogue("0022")
			yield(self, "dialogue_ended")
			yield(get_tree().create_timer(1.0), "timeout")
		load_dialogue("0023")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
		load_dialogue("0024")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
		load_dialogue("0025")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
		next_day()
	
func next_day():
	load_quick_transition(true)
	yield(transition, "end_of_transition")
	load_dialogue("0003")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(1.0), "timeout")
	load_dialogue("0026")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(0.5), "timeout")
	load_question("0005")
	yield(self, "answer_index")
	if answer_index == 1:
		load_dialogue("0027")
	elif answer_index == 2:
		load_dialogue("0028")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(1.0), "timeout")
	load_dialogue("0029")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(0.5), "timeout")
	explain_the_plan()

func explain_the_plan():
	load_question("0006")
	yield(self, "answer_index")
	if answer_index == 1:
		load_dialogue("0031")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(0.5), "timeout")
		init_the_plan()
	elif answer_index == 2:
		load_dialogue("0030")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
		explain_the_plan()

func init_the_plan():
	load_question("0007")
	yield(self, "answer_index")
	if answer_index == 1:
		load_dialogue("0032")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
	elif answer_index == 2:
		load_dialogue("0033")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
	load_dialogue("0070")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(0.5), "timeout")
	load_question("0008")
	yield(self, "answer_index")
	if answer_index == 1:
		load_dialogue("0034")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
	elif answer_index == 2:
		load_dialogue("0071")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(0.5), "timeout")
	explain_the_plan_2()
	
func explain_the_plan_2():
	load_question("0009")
	yield(self, "answer_index")
	if answer_index == 2:
		load_dialogue("0036")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
		init_the_plan_2()
	elif answer_index == 1:
		load_dialogue("0035")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
		explain_the_plan_2()	

func init_the_plan_2():
	pass
	# vai para terceira batalha
