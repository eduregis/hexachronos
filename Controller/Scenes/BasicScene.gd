extends Node2D

var DialogueBox = preload("res://View/Components/DialogueBox.tscn")
var Tile = preload("res://View/Components/HexagonTile.tscn")
var Character = preload("res://View/Components/Character.tscn")

var tile_code = []
var tile_map = []
var characters = []
var turn_order_index = 0

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
			character.character_info = character_info
			character.team = team
			character.set_position(tile_map[char_index.y][char_index.x].position)
			tile_map[char_index.y][char_index.x].char_tile()
			var paths = pathfinder(Vector2(char_index.x, char_index.y), character_info["range"])
			for path in paths:
				tile_map[path.y][path.x].path_tile()
				pass
			characters.append(character)
			self.add_child(character)

func pathfinder(tile_index, char_range):
	var new_paths = []
	
	if tile_index.y - 1 >= 0:
		if int(tile_index.y) % 2 != 0:
			if (tile_code[tile_index.y - 1].size() > tile_index.x + 1):
				if tile_map[tile_index.y - 1][tile_index.x + 1].occupied == false && tile_code[tile_index.y - 1][tile_index.x + 1] == 1:
					new_paths.append(Vector2(tile_index.x + 1, tile_index.y - 1))
					
		else:
			if (tile_code[tile_index.y - 1].size() > tile_index.x):
				if tile_map[tile_index.y - 1][tile_index.x].occupied == false && tile_code[tile_index.y - 1][tile_index.x] == 1:
					new_paths.append(Vector2(tile_index.x, tile_index.y - 1))	

	if (tile_code.size() > tile_index.y + 1):
		if int(tile_index.y) % 2 != 0:
			if (tile_code[tile_index.y + 1].size() > tile_index.x + 1):
				if tile_map[tile_index.y + 1][tile_index.x + 1].occupied == false && tile_code[tile_index.y + 1][tile_index.x + 1] == 1:
					new_paths.append(Vector2(tile_index.x + 1, tile_index.y + 1))

		else:
			if (tile_code[tile_index.y + 1].size() > tile_index.x):
				if tile_map[tile_index.y + 1][tile_index.x].occupied == false && tile_code[tile_index.y + 1][tile_index.x] == 1:
					new_paths.append(Vector2(tile_index.x, tile_index.y + 1))

	if (tile_code.size() > tile_index.y + 2):
		if (tile_code[tile_index.y + 2].size() > tile_index.x):
			if tile_map[tile_index.y + 2][tile_index.x].occupied == false && tile_code[tile_index.y + 2][tile_index.x] == 1:
				new_paths.append(Vector2(tile_index.x, tile_index.y + 2))

	if (tile_code.size() > tile_index.y + 1):
		if int(tile_index.y) % 2 != 0:
			if (tile_code[tile_index.y + 1].size() > tile_index.x):
				if tile_map[tile_index.y + 1][tile_index.x].occupied == false && tile_code[tile_index.y + 1][tile_index.x] == 1:
					new_paths.append(Vector2(tile_index.x, tile_index.y + 1))
		else:
			if (tile_code[tile_index.y + 1].size() > tile_index.x - 1):
				if tile_map[tile_index.y + 1][tile_index.x - 1].occupied == false && tile_code[tile_index.y + 1][tile_index.x - 1] == 1:
					new_paths.append(Vector2(tile_index.x - 1, tile_index.y + 1))

	if tile_index.y - 1 >= 0:
		if int(tile_index.y) % 2 != 0:
			if (tile_code[tile_index.y - 1].size() > tile_index.x):
				if tile_map[tile_index.y - 1][tile_index.x].occupied == false && tile_code[tile_index.y - 1][tile_index.x] == 1:
					new_paths.append(Vector2(tile_index.x, tile_index.y - 1))
		else:
			if (tile_code[tile_index.y - 1].size() > tile_index.x - 1):
				if tile_map[tile_index.y - 1][tile_index.x - 1].occupied == false && tile_code[tile_index.y - 1][tile_index.x - 1] == 1:
					new_paths.append(Vector2(tile_index.x - 1, tile_index.y - 1))
	
	if tile_index.y - 2 >= 0:
		if (tile_code[tile_index.y - 2].size() > tile_index.x):
			if tile_map[tile_index.y - 2][tile_index.x].occupied == false && tile_code[tile_index.y - 2][tile_index.x] == 1:
				new_paths.append(Vector2(tile_index.x, tile_index.y - 2))

	
	return new_paths
	
func load_dialogue(text_code):
	var window = get_viewport_rect().size
	var dialogueBox = DialogueBox.instance()
	dialogueBox.set_dialogue_code(text_code)
	dialogueBox.set_position(Vector2(window.x/2, window.y))
	self.add_child(dialogueBox)
