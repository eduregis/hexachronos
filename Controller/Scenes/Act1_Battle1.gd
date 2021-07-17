extends "res://Controller/Scenes/BattleScene.gd"

func _ready():
	load_quick_transition(true)
	set_ally("Protagonist")
	set_ally("Tanker")
	yield(get_tree().create_timer(1.0), "timeout")
	start_combat()
