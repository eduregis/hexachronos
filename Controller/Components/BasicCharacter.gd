extends Node2D

var Buff = preload("res://Controller/Components/Buff.gd")

var move_btn = preload("res://Assets/MenuButtons/move_btn.png")
var move_btn_clicked = preload("res://Assets/MenuButtons/move_btn_clicked.png")
var attack_btn = preload("res://Assets/MenuButtons/attack_btn.png")
var attack_btn_clicked = preload("res://Assets/MenuButtons/attack_btn_clicked.png")
var defend_btn = preload("res://Assets/MenuButtons/defend_btn.png")
var defend_btn_clicked = preload("res://Assets/MenuButtons/defend_btn_clicked.png")
var skill_btn = preload("res://Assets/MenuButtons/skill_btn.png")
var skill_btn_clicked = preload("res://Assets/MenuButtons/skill_btn_clicked.png")

# control variables
export var index = Vector2.ZERO
export var character_info = {}
export var team = ""
export var defeated = false
var able_move = true
var able_attack = true
var able_block = true
var able_skill = true

# buffs
var buffs = []

# basic stats
export var strength = 0
export var dexterity = 0
export var tecnical = 0
export var vitality = 0
export var agility = 0
export var luck = 0

# generated stats
export var hp = 0
export var hp_max = 0
export var attack = 0
export var defense = 0
export var hit_rate = 0
export var evasion = 0
export var crit_rate = 0
export var movement = 0
export var attack_range = 0
export var taunt = 2

signal char_attack_to
signal move
signal attack
signal defend
signal skill
signal defeated
signal pass_stage

var damage_text_position
var move_btn_position
var attack_btn_position
var defend_btn_position
var skill_btn_position

func _ready():
	set_stats()
	$RichTextLabel.modulate = Color(1,1,1,0)
	$Sprite.modulate = Color(1,1,1,0)
	$Menu.visible = false
	$SkillMenu.visible = false
	scale = Vector2(0.7, 0.7)
	if team == "foe":
		$Sprite.flip_h = true
	damage_text_position = $RichTextLabel.rect_position
	move_btn_position = $Menu/MoveButton.position
	attack_btn_position = $Menu/AttackButton.position
	defend_btn_position = $Menu/DefendButton.position
	skill_btn_position = $Menu/SkillButton.position
	var tween = get_node("Tween")
	yield(get_tree().create_timer((index.x + index.y) * 0.1), "timeout")
	tween.interpolate_property(
		$Sprite, "modulate", Color(1, 1, 1, 0) , Color(1, 1, 1, 1), 0.4, 
		Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	var yPosition = $Sprite.position.y
	tween.interpolate_property(
		$Sprite, "position:y", yPosition - 100 , yPosition, 0.4, 
		Tween.TRANS_QUAD, Tween.EASE_IN
	)
	tween.start()

func set_stats():
	strength = character_info["strength"]
	dexterity = character_info["dexterity"]
	tecnical = character_info["tecnical"]
	vitality = character_info["vitality"]
	agility = character_info["agility"]
	luck = character_info["luck"]
	attack_range = character_info["range"]
	
	hp_max = int(vitality*4.7)
	hp = hp_max
	attack = int(strength + (dexterity/2))
	defense = int(vitality + (agility/2))
	hit_rate = int(dexterity + (agility/2) + (luck/4))
	evasion = int(agility + (dexterity/2) + (luck/4))
	movement = int(agility/6) + 1
	
	print(character_info["name"])
	print("hp: ", hp)
	print("attack: ", attack)
	print("defense: ", defense)
	print("hit_rate: ", hit_rate)
	print("evasion: ", evasion)
	print("")

func buff_active(buff):
	pass

func remove_buffs():
	pass

func show_menu(move, attack, block, skill):
	if team == "ally":
		$Menu.visible = true
		$Menu/MoveButton.modulate = Color(1, 1, 1, 0)
		$Menu/AttackButton.visible = true
		$Menu/DefendButton.visible = true
		$Menu/SkillButton.visible = true
		
		able_submenus(move, attack, block, skill)
		
		var tween = get_node("Tween")
		$Menu/MoveButton.visible = true
		# Move Button Animation
		tween.interpolate_property(
			$Menu/MoveButton, "modulate", Color(1, 1, 1, 0) , Color(1, 1, 1, 1), 0.1, 
			Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
		)
		var xPosition = $Menu/MoveButton.position.x
		tween.interpolate_property(
			$Menu/MoveButton, "position:x", xPosition + 100 , xPosition, 0.1, 
			Tween.TRANS_LINEAR, Tween.EASE_IN
		)
		# Attack Button Animation
		tween.interpolate_property(
			$Menu/AttackButton, "modulate", Color(1, 1, 1, 0) , Color(1, 1, 1, 1), 0.1, 
			Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
		)
		$Menu/AttackButton.modulate = Color(1, 1, 1, 0)
		var xAttackPosition = $Menu/AttackButton.position.x
		tween.interpolate_property(
			$Menu/AttackButton, "position:x", xAttackPosition + 100 , xAttackPosition, 0.1, 
			Tween.TRANS_LINEAR, Tween.EASE_IN
		)
		# Defend Button Animation
		tween.interpolate_property(
			$Menu/DefendButton, "modulate", Color(1, 1, 1, 0) , Color(1, 1, 1, 1), 0.1, 
			Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
		)
		$Menu/DefendButton.modulate = Color(1, 1, 1, 0)
		var xDefendPosition = $Menu/DefendButton.position.x
		tween.interpolate_property(
			$Menu/DefendButton, "position:x", xDefendPosition - 100 , xDefendPosition, 0.1, 
			Tween.TRANS_LINEAR, Tween.EASE_IN
		)
		# Skill Button Animation
		$Menu/SkillButton.modulate = Color(1, 1, 1, 0)
		tween.interpolate_property(
			$Menu/SkillButton, "modulate", Color(1, 1, 1, 0) , Color(1, 1, 1, 1), 0.1, 
			Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
		)
		var xSkillPosition = $Menu/SkillButton.position.x
		tween.interpolate_property(
			$Menu/SkillButton, "position:x", xSkillPosition - 100 , xSkillPosition, 0.1, 
			Tween.TRANS_LINEAR, Tween.EASE_IN
		)
		tween.start()
	else:
		emit_signal("pass_stage")

func dismiss_menu():
	yield(get_tree().create_timer(0.2), "timeout")
	var yMovePosition = $Menu/MoveButton.position.y
	var xMovePosition = $Menu/MoveButton.position.x
	var attackPosition = $Menu/AttackButton.position
	var defendPosition = $Menu/DefendButton.position
	var ySkillPosition = $Menu/SkillButton.position.y
	var xSkillPosition = $Menu/SkillButton.position.x
	# Move Button Animation
	$MenuTween.interpolate_property(
		$Menu/MoveButton, "modulate", Color(1, 1, 1, 1) , Color(1, 1, 1, 0), 0.1, 
		Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	$MenuTween.interpolate_property(
		$Menu/MoveButton, "position:x", xMovePosition, xMovePosition  + 100, 0.1, 
		Tween.TRANS_LINEAR, Tween.EASE_IN
	)
	# Attack Button Animation
	$MenuTween.interpolate_property(
		$Menu/AttackButton, "modulate", Color(1, 1, 1, 1) , Color(1, 1, 1, 0), 0.1, 
		Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	$MenuTween.interpolate_property(
		$Menu/AttackButton, "position:x", attackPosition.x, attackPosition.x + 100, 0.1, 
		Tween.TRANS_LINEAR, Tween.EASE_IN
	)
	# Defend Button Animation
	$MenuTween.interpolate_property(
		$Menu/DefendButton, "modulate", Color(1, 1, 1, 1) , Color(1, 1, 1, 0), 0.1, 
		Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	$MenuTween.interpolate_property(
		$Menu/DefendButton, "position:x", defendPosition.x, defendPosition.x - 100, 0.1, 
		Tween.TRANS_LINEAR, Tween.EASE_IN
	)
	# Skill Button Animation
	$MenuTween.interpolate_property(
		$Menu/SkillButton, "modulate", Color(1, 1, 1, 1) , Color(1, 1, 1, 0), 0.1, 
		Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	$MenuTween.interpolate_property(
		$Menu/SkillButton, "position:x", xSkillPosition, xSkillPosition  - 100, 0.1, 
		Tween.TRANS_LINEAR, Tween.EASE_IN
	)
	$MenuTween.start()
	
func able_submenus(move, attack, block, skill):
	able_move = move
	able_attack = attack
	able_block = block
	able_skill = skill
	
func take_damage(char_attack):
	var hit_rate_final = ((85 * char_attack.hit_rate) / evasion)
	var hit_rate_random = (randi() % 100)
	if hit_rate_final >= hit_rate_random:
		var damage_oscilation = 80 + int(randi() % 30)
		var damage = int((damage_oscilation * char_attack.attack * char_attack.attack) / (defense * 100))
		var crit_rate_random = (randi() % 40)
		if luck >= crit_rate_random:
			print("CRITICAL")
			damage = int(damage * 1.5)
		if hp - damage < 0:
			hp = 0
		else:
			hp -= damage
		$RichTextLabel.bbcode_text = "[center]" + String(damage) + "[/center]"
	else:
		$RichTextLabel.bbcode_text = "[center]MISS[/center]"
	$Tween.interpolate_property(
		$RichTextLabel, "modulate", Color(1,1,1,1), Color(1,1,1,0), 1, 
		Tween.TRANS_SINE, Tween.EASE_IN_OUT
	)
	$Tween.interpolate_property(
		$RichTextLabel, "rect_position:y", damage_text_position.y, damage_text_position.y - 30, 1, 
		Tween.TRANS_SINE, Tween.EASE_IN_OUT
	)
	$Tween.start()

func take_tecnical_damage(char_attack):
	var hit_rate_final = ((85 * char_attack.hit_rate) / evasion)
	var hit_rate_random = (randi() % 100)
	if hit_rate_final >= hit_rate_random:
		var damage_oscilation = 90 + int(randi() % 30)
		var damage = int((damage_oscilation * char_attack.tecnical * char_attack.tecnical) / (defense * 60))
		var crit_rate_random = (randi() % 40)
		if luck >= crit_rate_random:
			print("CRITICAL")
			damage = int(damage * 1.5)
		if hp - damage < 0:
			hp = 0
		else:
			hp -= damage
		$RichTextLabel.bbcode_text = "[center]" + String(damage) + "[/center]"
	else:
		$RichTextLabel.bbcode_text = "[center]MISS[/center]"
	$Tween.interpolate_property(
		$RichTextLabel, "modulate", Color(1,1,1,1), Color(1,1,1,0), 1, 
		Tween.TRANS_SINE, Tween.EASE_IN_OUT
	)
	$Tween.interpolate_property(
		$RichTextLabel, "rect_position:y", damage_text_position.y, damage_text_position.y - 30, 1, 
		Tween.TRANS_SINE, Tween.EASE_IN_OUT
	)
	$Tween.start()

func move_to(tile_position):
	var tween1 = get_node("Tween")
	var tween2 = get_node("Tween")
	tween1.interpolate_property(
			self, "position:x", position.x , tile_position.x, 0.6, 
			Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
		)
	tween1.start()
	var yAnchor
	if position.y < tile_position.y:
		yAnchor = position.y - 30
	else:
		yAnchor = tile_position.y - 30
	tween2.interpolate_property(
			self, "position:y", position.y , yAnchor, 0.3, 
			Tween.TRANS_SINE, Tween.EASE_OUT
		)
	tween2.start()
	yield(tween2, "tween_completed")
	tween2.interpolate_property(
			self, "position:y", yAnchor, tile_position.y, 0.3, 
			Tween.TRANS_SINE, Tween.EASE_IN
		)
	tween2.start()

func _on_Tween_tween_completed(object, key):
	if hp <= 0 && defeated == false:
		emit_signal("defeated", team)
		defeated = true
	$RichTextLabel.rect_position = damage_text_position

func _on_MenuTween_tween_all_completed():
	$Menu/MoveButton.position = move_btn_position
	$Menu/AttackButton.position = attack_btn_position
	$Menu/DefendButton.position = defend_btn_position
	$Menu/SkillButton.position = skill_btn_position
	$Menu.visible = false
	$Menu/MoveButton.visible = false
	$Menu/MoveButton/Sprite.texture = move_btn
	$Menu/AttackButton.visible = false
	$Menu/AttackButton/Sprite.texture = attack_btn
	$Menu/DefendButton.visible = false
	$Menu/DefendButton/Sprite.texture = defend_btn
	$Menu/SkillButton.visible = false
	$Menu/SkillButton/Sprite.texture = skill_btn

# Ações do menu
func _on_MoveButtonHitBox_input_event(viewport, event, shape_idx):
	if able_move:
		if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
			$Menu/MoveButton/Sprite.texture = move_btn_clicked
			dismiss_menu()
			emit_signal("move")

func _on_MoveButtonHitBox_mouse_entered():
	if able_move:
		$Menu/MoveButton/Sprite.scale = Vector2(1.07, 1.07)

func _on_MoveButtonHitBox_mouse_exited():
	if able_move:
		$Menu/MoveButton/Sprite.scale = Vector2(1, 1)

func _on_AttackButtonHitBox_input_event(viewport, event, shape_idx):
	if able_attack:
		if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
			$Menu/AttackButton/Sprite.texture = attack_btn_clicked
			dismiss_menu()
			emit_signal("attack")

func _on_AttackButtonHitBox_mouse_entered():
	if able_attack:
		$Menu/AttackButton/Sprite.scale = Vector2(1.07, 1.07)

func _on_AttackButtonHitBox_mouse_exited():
	if able_attack:
		$Menu/AttackButton/Sprite.scale = Vector2(1, 1)

func _on_DefendButtonHitBox_input_event(viewport, event, shape_idx):
	if able_block:
		if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
			$Menu/DefendButton/Sprite.texture = defend_btn_clicked
			var defenseMode = Buff.new(1, "defense", 1.5)
			buff_active(defenseMode)
			buffs.append(defenseMode)
			dismiss_menu()
			emit_signal("defend")

func _on_DefendButtonHitBox_mouse_entered():
	if able_block:
		$Menu/DefendButton/Sprite.scale = Vector2(1.07, 1.07)

func _on_DefendButtonHitBox_mouse_exited():
	if able_block:
		$Menu/DefendButton/Sprite.scale = Vector2(1, 1)
	
func _on_SkillButtonHitBox_input_event(viewport, event, shape_idx):
	if able_skill:
		if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
			dismiss_menu()
			show_skill_menu()

func _on_SkillButtonHitBox_mouse_entered():
	if able_skill:
		$Menu/SkillButton/Sprite.scale = Vector2(1.07, 1.07)

func _on_SkillButtonHitBox_mouse_exited():
	if able_skill:
		$Menu/SkillButton/Sprite.scale = Vector2(1, 1)

# Menu de técnicas
func show_skill_menu():
	pass
