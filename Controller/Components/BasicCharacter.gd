extends Node2D

var move_btn = preload("res://Assets/MenuButtons/move_btn.png")
var move_btn_clicked = preload("res://Assets/MenuButtons/move_btn_clicked.png")
var attack_btn = preload("res://Assets/MenuButtons/attack_btn.png")
var attack_btn_clicked = preload("res://Assets/MenuButtons/attack_btn_clicked.png")

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
export var attack_range = 0

signal char_attack_to
signal move
signal attack
signal defeated
signal pass_stage

var damage_text_position
var move_btn_position
var attack_btn_position

func _ready():
	set_stats()
	$RichTextLabel.modulate = Color(1,1,1,0)
	$Sprite.modulate = Color(1,1,1,0)
	scale = Vector2(0.7, 0.7)
	if team == "foe":
		$Sprite.flip_h = true
	damage_text_position = $RichTextLabel.rect_position
	move_btn_position = $Menu/MoveButton.position
	attack_btn_position = $Menu/AttackButton.position
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

func show_menu(move_button):
	if team == "ally":
		$Menu.visible = true
		$Menu/MoveButton.modulate = Color(1, 1, 1, 0)
		$Menu/AttackButton.visible = true
		
		var tween = get_node("Tween")
		if move_button:
			$Menu/MoveButton.visible = true
			tween.interpolate_property(
				$Menu/MoveButton, "modulate", Color(1, 1, 1, 0) , Color(1, 1, 1, 1), 0.1, 
				Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
			)
			var yPosition = $Menu/MoveButton.position.y
			tween.interpolate_property(
				$Menu/MoveButton, "position:y", yPosition - 50 , yPosition, 0.1, 
				Tween.TRANS_LINEAR, Tween.EASE_IN
			)
			var xPosition = $Menu/MoveButton.position.x
			tween.interpolate_property(
				$Menu/MoveButton, "position:x", xPosition + 100 , xPosition, 0.1, 
				Tween.TRANS_LINEAR, Tween.EASE_IN
			)
		tween.interpolate_property(
			$Menu/AttackButton, "modulate", Color(1, 1, 1, 0) , Color(1, 1, 1, 1), 0.1, 
			Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
		)
		$Menu/AttackButton.modulate = Color(1, 1, 1, 0)
		var xAttackPosition = $Menu/AttackButton.position.x
		tween.interpolate_property(
			$Menu/AttackButton, "position:x", xAttackPosition + 112 , xAttackPosition, 0.1, 
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
	if $Menu/MoveButton.modulate == Color(1, 1, 1, 1):
		$MenuTween.interpolate_property(
			$Menu/MoveButton, "modulate", Color(1, 1, 1, 1) , Color(1, 1, 1, 0), 0.1, 
			Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
		)
		$MenuTween.interpolate_property(
			$Menu/MoveButton, "position:y", yMovePosition , yMovePosition - 50, 0.1, 
			Tween.TRANS_LINEAR, Tween.EASE_IN
		)
		$MenuTween.interpolate_property(
			$Menu/MoveButton, "position:x", xMovePosition, xMovePosition  + 100, 0.1, 
			Tween.TRANS_LINEAR, Tween.EASE_IN
		)
	$MenuTween.interpolate_property(
		$Menu/AttackButton, "modulate", Color(1, 1, 1, 1) , Color(1, 1, 1, 0), 0.1, 
		Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	$MenuTween.interpolate_property(
		$Menu/AttackButton, "position:x", attackPosition.x, attackPosition.x + 112, 0.1, 
		Tween.TRANS_LINEAR, Tween.EASE_IN
	)
	$MenuTween.start()
	
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

func _on_MenuTween_tween_all_completed():
	$Menu/MoveButton.position = move_btn_position
	$Menu/AttackButton.position = attack_btn_position
	$Menu.visible = false
	$Menu/MoveButton.visible = false
	$Menu/MoveButton/Sprite.texture = move_btn
	$Menu/AttackButton.visible = false
	$Menu/AttackButton/Sprite.texture = attack_btn

func _on_MoveButtonHitBox_input_event(viewport, event, shape_idx):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		$Menu/MoveButton/Sprite.texture = move_btn_clicked
		dismiss_menu()
		emit_signal("move")

func _on_MoveButtonHitBox_mouse_entered():
	$Menu/MoveButton/Sprite.scale = Vector2(0.67, 0.67)

func _on_MoveButtonHitBox_mouse_exited():
	$Menu/MoveButton/Sprite.scale = Vector2(0.63, 0.63)

func _on_AttackButtonHitBox_input_event(viewport, event, shape_idx):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		$Menu/AttackButton/Sprite.texture = attack_btn_clicked
		dismiss_menu()
		emit_signal("attack")

func _on_AttackButtonHitBox_mouse_entered():
	$Menu/AttackButton/Sprite.scale = Vector2(0.67, 0.67)

func _on_AttackButtonHitBox_mouse_exited():
	$Menu/AttackButton/Sprite.scale = Vector2(0.63, 0.63)


