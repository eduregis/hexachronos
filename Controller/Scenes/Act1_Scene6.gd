extends "res://Controller/Scenes/BasicScene.gd"

var talk_to_captain = false
var talk_to_hammer = false
var talk_to_billy = false
var thunder_is_annoucing = false

func _ready():
#	load_dialogue("0051")
#	yield(self, "dialogue_ended")
#	yield(get_tree().create_timer(1.0), "timeout")
#	load_dialogue("0052")
#	yield(self, "dialogue_ended")
#	yield(get_tree().create_timer(1.0), "timeout")
#	load_dialogue("0053")
#	yield(self, "dialogue_ended")
#	yield(get_tree().create_timer(1.0), "timeout")
	load_question("0013")
	yield(self, "answer_index")
	if answer_index == 1:
		speak_with_captain()
	elif answer_index == 2:
		speak_with_hammer()
	elif answer_index == 3:
		speak_with_billy()
		
		
func center_of_base():
	if (talk_to_captain == true) && (talk_to_billy == true) && (talk_to_hammer == true):
		load_dialogue("0061")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
		thunder_announcement()
	else:
		load_question("0016")
		yield(self, "answer_index")
		if answer_index == 1:
			speak_with_captain()
		elif answer_index == 2:
			speak_with_hammer()
		elif answer_index == 3:
			speak_with_billy()
		
func speak_with_captain():
	if talk_to_captain == false:
		load_dialogue("0059")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
		load_question("0018")
		yield(self, "answer_index")
		if answer_index == 2:
			load_dialogue("0068")
			yield(self, "dialogue_ended")
			yield(get_tree().create_timer(1.0), "timeout")
		load_dialogue("0072")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
		load_question("0019")
		yield(self, "answer_index")
		if answer_index == 1:
			load_dialogue("0082")
			yield(self, "dialogue_ended")
			yield(get_tree().create_timer(1.0), "timeout")
			thunder_is_annoucing = true
			thunder_announcement()
		elif answer_index == 2:
			load_dialogue("0073")
			yield(self, "dialogue_ended")
			yield(get_tree().create_timer(1.0), "timeout")
		talk_to_captain = true
	else:
		load_dialogue("0049b")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
	if thunder_is_annoucing == false:
		center_of_base()
	
func speak_with_hammer():
	if talk_to_hammer == false:
		load_dialogue("0055")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
		load_question("0017")
		yield(self, "answer_index")
		if answer_index == 1:
			load_dialogue("0056")
		elif answer_index == 2:
			load_dialogue("0057")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
		talk_to_hammer = true
	else:
		load_dialogue("0049a")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
	center_of_base()
	
	
func speak_with_billy():
	if talk_to_billy == false:
		load_dialogue("0058")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
		talk_to_billy = true
	else: 
		load_dialogue("0049b")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
	center_of_base()

func thunder_announcement():
	load_dialogue("0062")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(1.0), "timeout")
	load_question("0014")
	yield(self, "answer_index")
	if answer_index == 1:
		load_dialogue("0063")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
		load_question("0015")
		yield(self, "answer_index")
		if answer_index == 1:
			load_dialogue("0064")
			yield(self, "dialogue_ended")
			yield(get_tree().create_timer(1.0), "timeout")
			load_dialogue("0066")
			yield(self, "dialogue_ended")
			yield(get_tree().create_timer(1.0), "timeout")
		elif answer_index == 2:
			load_dialogue("0065")
			yield(self, "dialogue_ended")
			yield(get_tree().create_timer(1.0), "timeout")
	elif answer_index == 2:
		load_dialogue("0067")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
		load_dialogue("0068")
		yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
