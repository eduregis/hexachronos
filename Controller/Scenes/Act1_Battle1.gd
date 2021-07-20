extends "res://Controller/Scenes/BattleScene.gd"

func _ready():
	# setup
	load_background("black")
	load_quick_transition(false)
	yield(get_tree().create_timer(1.0), "timeout")
	load_background("bg_battle_01")
	dismiss_transition()
	yield(get_tree().create_timer(0.5), "timeout")
	combat()
#	allies[0].jump_animation()

func combat():
	set_ally("Protagonist")
	set_ally("Tanker")
	set_foe("BasicSoldier")
	set_foe("BasicSoldier")
	set_foe("BasicSoldier")
	set_foe("BasicSoldier")
	yield(get_tree().create_timer(1.0), "timeout")
	start_combat()
