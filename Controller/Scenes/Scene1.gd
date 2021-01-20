extends "res://Controller/Scenes/BasicScene.gd"

func _ready():
#	load_background("black")
	load_tilemap("0001")
	set_ally("Tanker", 1, 1)
	set_ally("Mechanic", 2, 2)
	set_foe("Foe", 3, 2)
#	load_dialogue("0001")
#	yield(self, "end_of_dialogue")
#	yield(get_tree().create_timer(0.5), "timeout")
#	load_dialogue("0002")
	pass

func post_menu_inserts():
	print("aa")

func post_move_inserts():
	print("bb")

func post_attack_menu_inserts():
	print("cc")

func post_attack_inserts():
	print("dd")

func post_turn_inserts():
	print("ee")
