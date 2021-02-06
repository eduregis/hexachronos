extends "res://Controller/Scenes/BasicScene.gd"

var Buff = preload("res://Controller/Components/Buff.gd")

func use_skill(char_position, skill_info):
	match skill_info["type"]:
		"area":
			match skill_info["name"]:
				"battlecry":
					var effect_zone = pathfinder(characters[turn_order_index].index, skill_info["range"], false)
					for path in effect_zone:
						for character in characters:
							if character.index == path && character.team == "ally":
								var buff = Buff.new(3, "attack", 1.2)
								character.buff_active(buff)
								character.buffs.append(buff)
					characters[turn_order_index].dismiss_skill_menu()
					next_turn()
			pass
		"self":
			print(characters[turn_order_index].name)
		"target":
			print(characters[turn_order_index].name, "mirou")
	print(char_position, skill_info)
