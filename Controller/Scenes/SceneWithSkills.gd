extends "res://Controller/Scenes/BasicScene.gd"

func use_skill(char_position, skill_info):
	match skill_info["type"]:
		"area":
			match skill_info["name"]:
				"battlecry":
					var path = pathfinder(characters[turn_order_index].position, skill_info["range"], false)
					
		"self":
			print(characters[turn_order_index].name)
		"target":
			print(characters[turn_order_index].name, "mirou")
	print(char_position, skill_info)
