extends "res://Controller/Scenes/BasicScene.gd"

func _ready():
#	load_background("black")
	load_tilemap("0001")
	set_ally("Tanker", 1, 1)
	set_ally("Mechanic", 2, 2)
	set_foe("Foe", 3, 2)
	start_combat()
	pass

func post_menu_inserts():
#	load_dialogue("0001")
#	yield(self, "end_of_dialogue")
#	yield(get_tree().create_timer(0.5), "timeout")
#	load_dialogue("0002")
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
	turn_order_index = 0
	turn_stage = "menu"
	for character in characters:
		self.remove_child(character)
	for tile_vector in tile_map:
		for tile in tile_vector:
			self.remove_child(tile)
	allies = 0
	foes = 0
	is_combat = false
