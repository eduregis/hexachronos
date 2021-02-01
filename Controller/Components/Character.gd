extends Node2D

# control variables
export var index = Vector2.ZERO
export var character_info = {}
export var team = ""
export var defeated = false

# basic stats
export var strength = 0
export var dexterity = 0
export var intelligence = 0
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

signal char_attack_to
signal defeated

var damage_text_position

func _ready():
	set_stats()
	$RichTextLabel.modulate = Color(1,1,1,0)
	$Sprite.modulate = Color(1,1,1,0)
	scale = Vector2(0.7, 0.7)
	if team == "foe":
		$Sprite.flip_h = true
	damage_text_position = $RichTextLabel.rect_position
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
	intelligence = character_info["intelligence"]
	vitality = character_info["vitality"]
	agility = character_info["agility"]
	luck = character_info["luck"]
	
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

func show_menu(move_button):
	$Menu.visible = true
	$Menu/AttackButton.modulate = Color(1, 1, 1, 0)
	if move_button:
		var tween = get_node("Tween")
		tween.interpolate_property(
			$Menu/AttackButton, "modulate", Color(1, 1, 1, 0) , Color(1, 1, 1, 1), 0.1, 
			Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
		)
		var yPosition = $Menu/AttackButton.position.y
		tween.interpolate_property(
			$Menu/AttackButton, "position:y", yPosition - 50 , yPosition, 0.1, 
			Tween.TRANS_LINEAR, Tween.EASE_IN
		)
		var xPosition = $Menu/AttackButton.position.x
		tween.interpolate_property(
			$Menu/AttackButton, "position:x", xPosition + 100 , xPosition, 0.1, 
			Tween.TRANS_LINEAR, Tween.EASE_IN
		)
		tween.start()
		
		
func dismiss_menu():
	$Menu.visible = true
	$Menu/AttackButton.visible = true

func take_damage(char_attack):
	var hit_rate_final = ((85 * char_attack.hit_rate) / evasion)
	var hit_rate_random = (randi() % 100)
	if hit_rate_final >= hit_rate_random:
		var damage_oscilation = 80 + (randi() % 30)
		var damage = ((damage_oscilation * char_attack.attack * char_attack.attack) / (defense * 100))
		var crit_rate_random = (randi() % 40)
		if luck >= crit_rate_random:
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
	


func _on_AttackButtonHitBox_input_event(viewport, event, shape_idx):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		print(character_info["name"])


func _on_AttackButtonHitBox_mouse_entered():
	$Menu/AttackButton/Sprite.scale = Vector2(0.67, 0.67)


func _on_AttackButtonHitBox_mouse_exited():
	$Menu/AttackButton/Sprite.scale = Vector2(0.63, 0.63)
