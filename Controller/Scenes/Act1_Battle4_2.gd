extends "res://Controller/Scenes/SceneWithSkills.gd"

func _ready():
	randomize()
	combat()

func combat():
	load_tilemap("0001")
	yield(get_tree().create_timer(1.0), "timeout")
	set_ally("Protagonist", 2, 2)
	set_ally("Tanker", 1, 5)
	set_ally("Mechanic", 2, 8)
	set_ally("Berserk", 2, 9)
	set_foe("Foe", 3, 3)
	set_foe("Foe", 3, 6)
	set_foe("Foe", 3, 8)
	yield(get_tree().create_timer(1.0), "timeout")
	able_skill = false
	start_combat()

func post_menu_inserts():
	pass

func post_move_inserts():
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
	get_tree().change_scene("res://View/Scenes/Act1_Scene5_2.tscn")
