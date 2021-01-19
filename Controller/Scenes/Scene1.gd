extends "res://Controller/Scenes/BasicScene.gd"

func _ready():
#	load_background("black")
	load_tilemap("0001")
	yield(get_tree().create_timer(1), "timeout")
	set_ally("Tanker", 1, 1)
	set_ally("Mechanic", 2, 2)
	set_foe("Foe", 3, 2)
#	load_dialogue("0001")
	pass
