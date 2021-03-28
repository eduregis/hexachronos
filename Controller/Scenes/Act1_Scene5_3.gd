extends "res://Controller/Scenes/SceneWithSkills.gd"

func _ready():
	load_dialogue("0050")
	yield(self, "dialogue_ended")
	yield(get_tree().create_timer(1.0), "timeout")
	load_quick_transition(false)
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().change_scene("res://View/Scenes/Act1_Battle5.tscn")
