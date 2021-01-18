extends Node2D

var DialogueBox = preload("res://View/Components/DialogueBox.tscn")
var Tile = preload("res://View/Components/HexagonTile.tscn")
var Character = preload("res://View/Components/Character.tscn")

var tile_code = []
var tile_map = []
var characters = []

var turn_order_index = 0
var turn_stage = "menu"

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		next_turn_stage()

func next_turn_stage():
	match turn_stage:
		"menu":
			turn_stage = "move"
			var paths = pathfinder(characters[turn_order_index].index, characters[turn_order_index].character_info["movement"])
			var path_index = 0
			for path in paths:
				tile_map[path.y][path.x].path_tile(path_index)
				path_index += 1
		"move":
			turn_stage = "attack menu"
			clean_paths()
		"attack menu":
			turn_stage = "attack"
			var paths = pathfinder(characters[turn_order_index].index, characters[turn_order_index].character_info["range"])
			var path_index = 0
			for path in paths:
				tile_map[path.y][path.x].path_tile(path_index)
				path_index += 1
		"attack":
			turn_stage = "end of turn"
			clean_paths()
		"end of turn":
			next_turn()
#	print(turn_stage)

func clean_paths():
	for tile_lines in tile_map:
		for tile in tile_lines:
			tile.remove_path()
			
func next_turn():
	if turn_order_index + 1 < characters.size():
		turn_order_index += 1
	else:
		turn_order_index = 0
	turn_stage = "menu"

func command_character_to(tile_index, tile_position):
	print(tile_index)
	if turn_stage == "move":
		move_character_to(tile_index, tile_position)
	elif turn_stage == "attack":
		attack_character_to(tile_index, tile_position)

func move_character_to(tile_index, tile_position):
	if tile_map[tile_index.y][tile_index.x].path:
		tile_map[tile_index.y][tile_index.x].char_tile()
		tile_map[characters[turn_order_index].index.y][characters[turn_order_index].index.x].occupied = false
		
		characters[turn_order_index].index = tile_index
		characters[turn_order_index].move_to(tile_position)
		
		next_turn_stage()

func attack_character_to(tile_index, tile_position):
	for character in characters:
		if character.index == tile_index:
			if character.team != characters[turn_order_index].team:
				character.take_damage(characters[turn_order_index])
	next_turn_stage()

func load_tilemap(text_code):
	
	var file = File.new()
	file.open("res://Database/hexachronosTilemaps.json", file.READ)
	var json = file.get_as_text()
	var json_result = JSON.parse(json).result
	file.close()
	
	for tilemaps in json_result["tilemaps"]:
		if tilemaps["id"] == text_code:
			tile_code = tilemaps["tiles"]
	
	instance_tilemap()

func instance_tilemap():
	var window = get_viewport_rect().size
	var x = 0
	var y = 0
	for array in tile_code:
		x = 0
		var tile_vector_position = []
		for cell in array:
			var tile_position = Vector2(window.x/6 + x*185 + (y % 2)*92, window.y/2 + y *30)
			var tile = Tile.instance()
			tile.set_position(tile_position)
			tile.tile_index = Vector2(x, y)
			tile_vector_position.append(tile)
			if cell == 1:
				tile.connect("path_move_to", self, "command_character_to")
				self.add_child(tile)
			x += 1
		tile_map.append(tile_vector_position)
		y += 1

func set_ally(char_name, char_index_x, char_index_y):
	set_character(char_name, Vector2(char_index_x, char_index_y), "ally")

func set_foe(char_name, char_index_x, char_index_y):
	set_character(char_name, Vector2(char_index_x, char_index_y), "foe")

func set_character(char_name, char_index, team):
	var file = File.new()
	file.open("res://Database/hexachronosCharacters.json", file.READ)
	var json = file.get_as_text()
	var json_result = JSON.parse(json).result
	file.close()
	
	for character_info in json_result["characters"]:
		if character_info["name"] == char_name:
			var character = Character.instance()
			character.index = Vector2(char_index.x, char_index.y)
			character.character_info = character_info
			character.team = team
			character.set_position(tile_map[char_index.y][char_index.x].position)
			tile_map[char_index.y][char_index.x].char_tile()
			character.connect("char_attack_to", self, "command_character_to")
			characters.append(character)
			self.add_child(character)

func pathfinder(tile_index, char_range):
	var paths = []
	var incoming_paths = []
	
	if tile_index.y - 1 >= 0:
		if int(tile_index.y) % 2 != 0:
			if (tile_code[tile_index.y - 1].size() > tile_index.x + 1):
				if (tile_map[tile_index.y - 1][tile_index.x + 1].occupied == false || turn_stage == "attack") && tile_code[tile_index.y - 1][tile_index.x + 1] == 1:
					paths.append(Vector2(tile_index.x + 1, tile_index.y - 1))
		else:
			if (tile_code[tile_index.y - 1].size() > tile_index.x):
				if (tile_map[tile_index.y - 1][tile_index.x].occupied == false || turn_stage == "attack") && tile_code[tile_index.y - 1][tile_index.x] == 1:
					paths.append(Vector2(tile_index.x, tile_index.y - 1))	

	if (tile_code.size() > tile_index.y + 1):
		if int(tile_index.y) % 2 != 0:
			if (tile_code[tile_index.y + 1].size() > tile_index.x + 1):
				if (tile_map[tile_index.y + 1][tile_index.x + 1].occupied == false || turn_stage == "attack") && tile_code[tile_index.y + 1][tile_index.x + 1] == 1:
					paths.append(Vector2(tile_index.x + 1, tile_index.y + 1))
		else:
			if (tile_code[tile_index.y + 1].size() > tile_index.x):
				if (tile_map[tile_index.y + 1][tile_index.x].occupied == false || turn_stage == "attack") && tile_code[tile_index.y + 1][tile_index.x] == 1:
					paths.append(Vector2(tile_index.x, tile_index.y + 1))

	if (tile_code.size() > tile_index.y + 2):
		if (tile_code[tile_index.y + 2].size() > tile_index.x):
			if (tile_map[tile_index.y + 2][tile_index.x].occupied == false || turn_stage == "attack") && tile_code[tile_index.y + 2][tile_index.x] == 1:
				paths.append(Vector2(tile_index.x, tile_index.y + 2))

	if (tile_code.size() > tile_index.y + 1):
		if int(tile_index.y) % 2 != 0:
			if (tile_code[tile_index.y + 1].size() > tile_index.x):
				if (tile_map[tile_index.y + 1][tile_index.x].occupied == false || turn_stage == "attack") && tile_code[tile_index.y + 1][tile_index.x] == 1:
					paths.append(Vector2(tile_index.x, tile_index.y + 1))
		else:
			if (0 <= tile_index.x - 1):
				if (tile_map[tile_index.y + 1][tile_index.x - 1].occupied == false || turn_stage == "attack") && tile_code[tile_index.y + 1][tile_index.x - 1] == 1:
					paths.append(Vector2(tile_index.x - 1, tile_index.y + 1))

	if tile_index.y - 1 >= 0:
		if int(tile_index.y) % 2 != 0:
			if (tile_code[tile_index.y - 1].size() > tile_index.x):
				if (tile_map[tile_index.y - 1][tile_index.x].occupied == false || turn_stage == "attack") && tile_code[tile_index.y - 1][tile_index.x] == 1:
					paths.append(Vector2(tile_index.x, tile_index.y - 1))
		else:
			if (0 <= tile_index.x - 1):
				if (tile_map[tile_index.y - 1][tile_index.x - 1].occupied == false || turn_stage == "attack") && tile_code[tile_index.y - 1][tile_index.x - 1] == 1:
					paths.append(Vector2(tile_index.x - 1, tile_index.y - 1))
	
	if tile_index.y - 2 >= 0:
		if (tile_code[tile_index.y - 2].size() > tile_index.x):
			if (tile_map[tile_index.y - 2][tile_index.x].occupied == false || turn_stage == "attack") && tile_code[tile_index.y - 2][tile_index.x] == 1:
				paths.append(Vector2(tile_index.x, tile_index.y - 2))

	if char_range - 1 > 0:
		for path in paths:
			var new_paths = pathfinder(path, char_range - 1)
			for new_path in new_paths:
				if paths.find(new_path, 0) == -1 && incoming_paths.find(new_path, 0) == -1: 
					incoming_paths.append(new_path)
	
	for path in incoming_paths:
		paths.append(path)
	
	return paths
	
func load_dialogue(text_code):
	var window = get_viewport_rect().size
	var dialogueBox = DialogueBox.instance()
	dialogueBox.set_dialogue_code(text_code)
	dialogueBox.set_position(Vector2(window.x/2, window.y))
	self.add_child(dialogueBox)
