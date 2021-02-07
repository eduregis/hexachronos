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
					var tauntUp = Buff.new(3, "taunt", 2)
					characters[turn_order_index].buff_active(tauntUp)
					characters[turn_order_index].buffs.append(tauntUp)
					characters[turn_order_index].dismiss_skill_menu()
					next_turn()
				"maelstrom":
					var effect_zone = pathfinder(characters[turn_order_index].index, skill_info["range"], false)
					for path in effect_zone:
						for character in characters:
							if character.index == path && character.team == "ally":
								character.take_damage(characters[turn_order_index])
					next_turn()
			pass
		"self":
			match skill_info["name"]:
				"berserk":
					var berserkMode = Buff.new(3, "berserk", 1.5)
					characters[turn_order_index].buff_active(berserkMode)
					characters[turn_order_index].buffs.append(berserkMode)
					characters[turn_order_index].dismiss_skill_menu()
					next_turn()
			print(characters[turn_order_index].name)
		"target":
			print(characters[turn_order_index].name, "mirou")
	print(char_position, skill_info)
