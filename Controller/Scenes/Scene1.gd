extends "res://Controller/Scenes/BasicScene.gd"

func _ready():
	load_tilemap("0001")
	set_ally("Tanker", 1, 1)
	set_ally("Mechanic", 2, 2)
	#load_dialogue("0001")
	
