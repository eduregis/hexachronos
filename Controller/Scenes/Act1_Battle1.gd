extends "res://Controller/Scenes/SceneWithSkills.gd"

func _ready():
	randomize()
	combat()

func combat():
	load_tilemap("0001")
	yield(get_tree().create_timer(1.0), "timeout")
	set_ally("Protagonist", 1, 3)
	set_foe("Foe", 2, 5)
	yield(get_tree().create_timer(1.0), "timeout")
	load_dialogue("00069a")
	yield(self, "dialogue_ended")
	able_attack = false
	able_block = false
	able_skill = false
	start_combat()

func post_menu_inserts():
	pass

func post_move_inserts():
	if able_attack == false:
		yield(get_tree().create_timer(1.0), "timeout")
		if characters[turn_order_index].team == "ally":
			check_if_has_targets()
			yield(get_tree().create_timer(1.0), "timeout")
			if has_target:
				if able_attack == false:
					able_attack = true
					load_dialogue("00069b")
					yield(self, "dialogue_ended")
					yield(get_tree().create_timer(1.0), "timeout")
			else:
				if able_block == false:
					able_block = true
					load_dialogue("00069c")
					yield(self, "dialogue_ended")
					yield(get_tree().create_timer(1.0), "timeout")
		characters[turn_order_index].show_menu(false, able_attack, able_block, able_skill)
	else:
		check_if_has_targets()
		yield(get_tree().create_timer(1.0), "timeout")
		if able_block == false && characters[turn_order_index].team == "ally" && !has_target:
			able_block = true
			load_dialogue("00069c")
			yield(self, "dialogue_ended")
		yield(get_tree().create_timer(1.0), "timeout")
		characters[turn_order_index].show_menu(false, able_attack, able_block, able_skill)

func post_attack_menu_inserts():
	pass

func post_attack_inserts():
	pass

func post_turn_inserts():
	pass
	
func end_combat():
	turn_stage = "end combat"
	yield(get_tree().create_timer(1.0), "timeout")
	load_quick_transition(false)
	yield(get_tree().create_timer(0.4), "timeout")
	get_tree().change_scene("res://View/Scenes/Act1_Scene2.tscn")
	
#	turn_order_index = 0
#	turn_stage = "menu"
#	for character in characters:
#		self.remove_child(character)
#	for tile_vector in tile_map:
#		for tile in tile_vector:
#			self.remove_child(tile)
#	tile_map = []
#	tile_code = []
#	allies = 0
#	foes = 0
#	is_combat = false
#	yield(get_tree().create_timer(1.0), "timeout")
#	if allies == 0:
#		print("you lose")
#		combat()
#	elif foes == 0:
#		print("you win")
		
