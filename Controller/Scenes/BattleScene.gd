extends "res://Controller/Scenes/BasicScene.gd"

var Character = preload("res://View/Components/Character.tscn")
var BattleMenuHUD = preload("res://View/Components/BattleMenuHUD.tscn")

var allies = []
var foes = []

func set_ally(char_name):
	set_character(char_name, "ally", true)

func set_foe(char_name):
	set_character(char_name, "foe", true)

func set_character(char_name, team, is_character):
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
			character.connect("char_attack_to", self, "command_character_to")
			character.connect("defeated", self, "character_defeated")
			character.connect("move", self, "menu_to_move")
			character.connect("attack", self, "menu_to_attack")
			character.connect("defend", self, "next_turn")
			character.connect("skill", self, "use_skill")
			character.connect("skill_menu", self, "skill_menu")
			character.connect("pass_stage", self, "next_turn_stage")
			character.connect("skill_range_on", self, "skill_range_on")
			character.connect("skill_range_off", self, "skill_range_off")
			if team == "ally":
				allies.append(character)
			elif team == "foe":
				foes.append(character)
			
#			self.add_child(character)

func start_combat():
	var window = get_viewport_rect().size
	var x_distances = [0, 150, -75, 75, -150]
	# colocando os personagens no combate
	x_distances = shuffleList(x_distances)
	for i in range(0, allies.size()):
		allies[i].set_position(Vector2(window.x/4 + x_distances[i], 3*window.y/5 + (allies.size() * 35) - (i * 70)))
		yield(get_tree().create_timer(0.2), "timeout")
		allies[i].z_index = 100 - i
		self.add_child(allies[i])
	x_distances = shuffleList(x_distances)
	for i in range(0, foes.size()):
		foes[i].set_position(Vector2(3*window.x/4 + x_distances[i], 3*window.y/5 + (foes.size() * 35) - (i * 70)))
		yield(get_tree().create_timer(0.2), "timeout")
		foes[i].z_index = 100 - i
		self.add_child(foes[i])
	# colocando a HUD
	var battleMenuHUD = BattleMenuHUD.instance()
	battleMenuHUD.set_position(Vector2(185, window.y - 120))
	battleMenuHUD.z_index = 101
	self.add_child(battleMenuHUD)
	
		
func shuffleList(list):
	var shuffledList = []
	var indexList = range(list.size())
	for i in range(list.size()):
		randomize()
		var x = randi()%indexList.size()
		shuffledList.append(list[x])
		indexList.remove(x)
		list.remove(x)
	return shuffledList
