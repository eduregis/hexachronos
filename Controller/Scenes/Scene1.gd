extends "res://Controller/Scenes/BasicScene.gd"

func _ready():
#	load_dialogue("0001")
#	load_question("0001")
#	yield(self, "answer_index")
#	load_quick_transition(true)
#	if answer_index == 1:
#		yield(transition, "end_of_transition")
#		load_dialogue("0001")

#	GERAR TILEMAP
	load_tilemap("0001")
	set_ally("Tanker", 1, 1)
#	set_ally("Mechanic", 2, 2)
	set_foe("Foe", 3, 2)
	start_combat()

#	SEQUENCIA DE DIALOGOS
	
#	load_background("test")
#	yield(get_tree().create_timer(1.5), "timeout")
#	load_background("black")
#	yield(get_tree().create_timer(1.5), "timeout")
#	load_background("test")
#	load_dialogue("0001")
#	yield(self, "end_of_dialogue")
#	yield(get_tree().create_timer(0.5), "timeout")
#	load_dialogue("0002")
	pass

func post_menu_inserts():
	pass

func post_move_inserts():
	pass

func post_attack_menu_inserts():
	pass

func post_attack_inserts():
	pass

func post_turn_inserts():
	pass

func end_combat():
	if allies == 0:
		print("you lose")
	elif foes == 0:
		print("you win")
	turn_order_index = 0
	turn_stage = "menu"
	for character in characters:
		self.remove_child(character)
	for tile_vector in tile_map:
		for tile in tile_vector:
			self.remove_child(tile)
	tile_map = []
	tile_code = []
	allies = 0
	foes = 0
	is_combat = false
