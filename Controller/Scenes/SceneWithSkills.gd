extends "res://Controller/Scenes/BasicScene.gd"

var Buff = preload("res://Controller/Components/Buff.gd")

func use_skill(char_position, skill_info):
	turn_stage = "skill"
	match skill_info["type"]:
		"area":
			match skill_info["name"]:
				"battlecry":
					var effect_zone = pathfinder(char_position, skill_info["range"], false)
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
					var effect_zone = pathfinder(char_position, skill_info["range"], false)
					for path in effect_zone:
						for character in characters:
							if character.index == path && (character.team != characters[turn_order_index].team) && (character.defeated == false):
								character.take_damage(characters[turn_order_index])
					next_turn()
			pass
		"self":
			match skill_info["name"]:
				"berserkmode":
					var berserkMode = Buff.new(3, "berserk", 1.5)
					characters[turn_order_index].buff_active(berserkMode)
					characters[turn_order_index].buffs.append(berserkMode)
					characters[turn_order_index].dismiss_skill_menu()
					next_turn()
			print(characters[turn_order_index].name)
		"target":
			clean_paths()
			yield(get_tree().create_timer(1.0), "timeout")
			characters[turn_order_index].dismiss_skill_menu()
			paths = pathfinder(char_position, skill_info["range"], false)
			var path_index = 0
			for path in paths:
				tile_map[path.y][path.x].path_tile(path_index)
				path_index += 1
			actual_target_skill = skill_info

func target_skill_character_to(tile_index, tile_position):
	match actual_target_skill["name"]:
		"resurrect":
			for character in characters:
				if character.index == tile_index && character.team == characters[turn_order_index].team && character.defeated == true:
					character.defeated = false
					character.hp = int(character.hp_max/2)
					print("funcionou")
					yield(get_tree().create_timer(1.0), "timeout")
					clean_paths()
					next_turn_stage()
					actual_target_skill = {}
		"longshot":
			for character in characters:
				if character.index == tile_index && character.team != characters[turn_order_index].team:
					character.take_tecnical_damage(characters[turn_order_index])
					yield(get_tree().create_timer(1.0), "timeout")
					clean_paths()
					next_turn_stage()
					actual_target_skill = {}
