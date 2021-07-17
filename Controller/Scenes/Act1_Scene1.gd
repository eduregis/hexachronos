extends "res://Controller/Scenes/BasicScene.gd"

func _ready():
	randomize()
#	load_dialogue("0001")
#	load_question("0001")
#	yield(self, "answer_index")
#	load_quick_transition(true)
#	if answer_index == 1:
#		yield(transition, "end_of_transition")
#		load_dialogue("0001")

#	GERAR TILEMAP
#	load_tilemap("0001")
#	set_ally("Hammer", 1, 3)
##	set_ally("Sniper", 0, 2)
#	set_foe("Foe", 2, 4)
#	set_foe("Foe", 1, 5)
#	start_combat()

#	SEQUENCIA DE DIALOGOS
#	load_background("test")
#	yield(get_tree().create_timer(1.5), "timeout")
#	load_background("black")
#	yield(get_tree().create_timer(1.5), "timeout")
#	load_background("test")
	load_dialogue("0001")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(1.0), "timeout")
	load_dialogue("0006")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(1.0), "timeout")
	load_dialogue("0007")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(1.0), "timeout")
	load_dialogue("0008")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(1.0), "timeout")
	load_dialogue("0002")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(1.0), "timeout")
	load_dialogue("0009")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(1.0), "timeout")
	# vai para primeira batalha
	
