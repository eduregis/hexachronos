extends "res://Controller/Scenes/BasicScene.gd"

func _ready():
	load_background("black")
	load_quick_transition(false)
	yield(get_tree().create_timer(1.0), "timeout")
	load_background("bg_battle_01")
	dismiss_transition()
	yield(get_tree().create_timer(1.0), "timeout")
	randomize()
	load_dialogue("00069d")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(1.0), "timeout")
	load_quick_transition(false)
	yield(get_tree().create_timer(0.4), "timeout")
	# vai para segunda batalha
