extends Node2D

var DialogueBox = preload("res://View/DialogueBox.tscn")
var Tile = preload("res://View/Components/HexagonTile.tscn")

var tile_map = []

var tile_map_position = []

func _ready():
	load_tilemap("0001")
	load_dialogue("0001")
	
func load_tilemap(text_code):
	var file = File.new()
	file.open("res://Database/hexachronosTilemaps.json", file.READ)
	var json = file.get_as_text()
	var json_result = JSON.parse(json).result
	file.close()
	
	for tilemaps in json_result["tilemaps"]:
		if tilemaps["id"] == text_code:
			tile_map = tilemaps["tiles"]
	
	instance_tilemap()

func instance_tilemap():
	var window = get_viewport_rect().size
	var x = 0
	var y = 0
	for array in tile_map:
		x = 0
		var tile_vector_position = []
		for cell in array:
			var tile_position = Vector2(window.x/6 + x*185 + (y % 2)*92, window.y/2 + y *30)
			var tile = Tile.instance()
			tile.set_position(tile_position)
			tile.tile_index = Vector2(x, y)
			tile_vector_position.append(tile)
			self.add_child(tile)
			x += 1
		tile_map_position.append(tile_vector_position)
		y += 1
	print(tile_map_position[0][0])


func load_dialogue(text_code):
	var window = get_viewport_rect().size
	var dialogueBox = DialogueBox.instance()
	dialogueBox.set_dialogue_code(text_code)
	dialogueBox.set_position(Vector2(window.x/2, window.y))
	self.add_child(dialogueBox)
