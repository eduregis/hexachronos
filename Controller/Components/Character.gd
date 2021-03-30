extends "res://Controller/Components/BasicCharacter.gd"

var sam_jump = preload("res://Assets/Animations/Sam/Sam_Jump_SpriteSheet.png")
var soldier_jump = preload("res://Assets/Animations/Soldier/Soldier_Jump_SpriteSheet.png")
var thunder_jump = preload("res://Assets/Animations/Thunder/Thunder_Jump_SpriteSheet.png")
var luka_jump = preload("res://Assets/Animations/Luka/Luka_Jump_SpriteSheet.png")
var salvato_jump = preload("res://Assets/Animations/Salvato/Salvato_Jump_SpriteSheet.png")
var billy_jump = preload("res://Assets/Animations/Billy/Billy_Jump_SpriteSheet.png")
var dandara_jump = preload("res://Assets/Animations/Dandara/Dandara_Jump_SpriteSheet.png")
var morya_jump = preload("res://Assets/Animations/Morya/Morya_Jump_SpriteSheet.png")

var sam_hurt = preload("res://Assets/Animations/Sam/Sam_Hurt_SpriteSheet.png")
var soldier_hurt = preload("res://Assets/Animations/Soldier/Soldier_Hurt_SpriteSheet.png")
var thunder_hurt = preload("res://Assets/Animations/Thunder/Thunder_Hurt_SpriteSheet.png")
var luka_hurt = preload("res://Assets/Animations/Luka/Luka_Hurt_SpriteSheet.png")
var salvato_hurt = preload("res://Assets/Animations/Salvato/Salvato_Hurt_SpriteSheet.png")
var billy_hurt = preload("res://Assets/Animations/Billy/Billy_Hurt_SpriteSheet.png")
var dandara_hurt = preload("res://Assets/Animations/Dandara/Dandara_Hurt_SpriteSheet.png")
var morya_hurt = preload("res://Assets/Animations/Morya/Morya_Hurt_SpriteSheet.png")

var sam_faint = preload("res://Assets/Animations/Sam/Sam_Faint_SpriteSheet.png")
var soldier_faint = preload("res://Assets/Animations/Soldier/Soldier_Faint_SpriteSheet.png")
var thunder_faint = preload("res://Assets/Animations/Thunder/Thunder_Faint_SpriteSheet.png")
var luka_faint = preload("res://Assets/Animations/Luka/Luka_Faint_SpriteSheet.png")
var salvato_faint = preload("res://Assets/Animations/Salvato/Salvato_Faint_SpriteSheet.png")
var billy_faint = preload("res://Assets/Animations/Billy/Billy_Faint_SpriteSheet.png")
var dandara_faint = preload("res://Assets/Animations/Dandara/Dandara_Faint_SpriteSheet.png")
var morya_faint = preload("res://Assets/Animations/Morya/Morya_Faint_SpriteSheet.png")

var sam_attack = preload("res://Assets/Animations/Sam/Sam_Attack_SpriteSheet.png")
var soldier_attack = preload("res://Assets/Animations/Soldier/Soldier_Attack_SpriteSheet.png")
var thunder_attack = preload("res://Assets/Animations/Thunder/Thunder_Attack_SpriteSheet.png")
var luka_attack = preload("res://Assets/Animations/Luka/Luka_Attack_SpriteSheet.png")
var salvato_attack = preload("res://Assets/Animations/Salvato/Salvato_Attack_SpriteSheet.png")
var billy_attack = preload("res://Assets/Animations/Billy/Billy_Attack_SpriteSheet.png")
var dandara_attack = preload("res://Assets/Animations/Dandara/Dandara_Attack_SpriteSheet.png")
var morya_attack = preload("res://Assets/Animations/Morya/Morya_Attack_SpriteSheet.png")

signal skill_range_on
signal skill_range_off

var skill01_btn_position

func buff_active(buff):
	match buff.effect:
		"defense":
			defense = int(defense * buff.value)
			multi_text_animation(["+ DEFESA"])
		"attack":
			attack = int(attack * buff.value)
			multi_text_animation(["+ ATAQUE"])
		"hit_rate":
			hit_rate = int(hit_rate * buff.value)
			multi_text_animation(["+ PRECISÃO"])
		"evasion":
			evasion = int(evasion * buff.value)
			multi_text_animation(["+ EVASÃO"])
		"taunt":
			taunt = int(taunt * buff.value)
		"berserk":
			attack = int(attack * buff.value)
			defense = int(defense * buff.value)
			multi_text_animation(["+ ATAQUE", "- DEFESA"])

func remove_buffs():
	for buff in buffs:
		buff.duration = buff.duration - 1
		if buff.duration <= 0:
			match buff.effect:
				"defense":
					defense = int(defense / buff.value)
				"attack":
					attack = int(attack / buff.value)
				"hit_rate":
					hit_rate = int(hit_rate / buff.value)
				"evasion":
					evasion = int(evasion / buff.value)
				"taunt":
					taunt = int(taunt / buff.value)
				"berserk":
					attack = int(attack / buff.value)
					defense = int(defense / buff.value)
			buffs.erase(buff)

func show_skill_menu():
	yield(get_tree().create_timer(0.5), "timeout")
	$SkillMenu.visible = true
	$SkillMenu/Skill_01Button.modulate = Color(1, 1, 1, 0)
	skill01_btn_position = $SkillMenu/Skill_01Button.position
	$SkillMenu/Skill_01Button.visible = true
	$SkillMenuTween.interpolate_property(
		$SkillMenu/Skill_01Button, "modulate", Color(1, 1, 1, 0) , Color(1, 1, 1, 1), 0.1, 
		Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	var ySkill_01Position = $SkillMenu/Skill_01Button.position.y
	$SkillMenuTween.interpolate_property(
		$SkillMenu/Skill_01Button, "position:y", ySkill_01Position - 50 , ySkill_01Position, 0.1, 
		Tween.TRANS_LINEAR, Tween.EASE_IN
	)
	var xSkill_01Position = $SkillMenu/Skill_01Button.position.x
	$SkillMenuTween.interpolate_property(
		$SkillMenu/Skill_01Button, "position:x", xSkill_01Position - 100 , xSkill_01Position, 0.1, 
		Tween.TRANS_LINEAR, Tween.EASE_IN
	)
	$SkillMenuTween.start()
	
func dismiss_skill_menu():
	var xSkill_01Position = $SkillMenu/Skill_01Button.position.x
	var ySkill_01Position = $SkillMenu/Skill_01Button.position.y
	$SkillMenuTween.interpolate_property(
		$SkillMenu/Skill_01Button, "modulate", Color(1, 1, 1, 1) , Color(1, 1, 1, 0), 0.1, 
		Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	$SkillMenuTween.interpolate_property(
		$SkillMenu/Skill_01Button, "position:x", xSkill_01Position, xSkill_01Position  - 100, 0.1, 
		Tween.TRANS_LINEAR, Tween.EASE_IN
	)
	$SkillMenuTween.interpolate_property(
		$SkillMenu/Skill_01Button, "position:y", ySkill_01Position, ySkill_01Position  - 50, 0.1, 
		Tween.TRANS_LINEAR, Tween.EASE_IN
	)
	$SkillMenuTween.start()
	yield($SkillMenuTween, "tween_completed")
	$SkillMenu.visible = false
	$SkillMenu/Skill_01Button.visible = false
	
func _on_Skill_01ButtonHitBox_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		emit_signal("skill", index, character_info["skills"][0])
		
func _on_Skill_01ButtonHitBox_mouse_entered():
	$SkillMenu/Skill_01Button/Sprite.scale = Vector2(1.07, 1.07)
	emit_signal("skill_range_on", index, character_info["skills"][0]["range"])

func _on_Skill_01ButtonHitBox_mouse_exited():
	$SkillMenu/Skill_01Button/Sprite.scale = Vector2(1, 1)
	emit_signal("skill_range_off", index, character_info["skills"][0]["range"])

func _on_SkillMenuTween_tween_all_completed():
	$SkillMenu/Skill_01Button.position = skill01_btn_position

func set_sprite():
	$Sprite.scale = Vector2(0.4, 0.4)
	change_to_jump_sprite()
		
func change_to_jump_sprite():
	$Sprite.hframes = 32
	$Sprite.frame = 0
	match character_info["name"]:
		"Protagonist":
			$Sprite.texture = luka_jump
		"Mechanic":
			$Sprite.texture = sam_jump
		"Foe":
			$Sprite.texture = soldier_jump
		"Tanker":
			$Sprite.texture = thunder_jump
		"Captain":
			$Sprite.texture = salvato_jump
		"Berserk":
			$Sprite.texture = billy_jump
		"Hammer":
			$Sprite.texture = dandara_jump
		"Sniper":
			$Sprite.texture = morya_jump

func jump_animation(tile_position):
	var tween1 = get_node("Tween")
	var tween2 = get_node("Tween")
	$AnimationPlayer.play("Jump")
	yield(get_tree().create_timer(0.26), "timeout")
	tween1.interpolate_property(
			self, "position:x", position.x , tile_position.x, 0.26, 
			Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
		)
	tween1.start()
	var yAnchor
	if position.y < tile_position.y:
		yAnchor = position.y - 30
	else:
		yAnchor = tile_position.y - 30
	tween2.interpolate_property(
			self, "position:y", position.y , yAnchor, 0.16, 
			Tween.TRANS_SINE, Tween.EASE_OUT
		)
	tween2.start()
	yield(tween2, "tween_completed")
	z_index = index.y
	tween2.interpolate_property(
			self, "position:y", yAnchor, tile_position.y, 0.10, 
			Tween.TRANS_SINE, Tween.EASE_IN
		)
	tween2.start()
	yield(tween2, "tween_completed")
	yield(get_tree().create_timer(0.12), "timeout")
	$AnimationPlayer.stop()
	z_index = index.y

func change_to_hurt_sprite():
#	yield(get_tree().create_timer(0.48), "timeout")
	$Sprite.hframes = 20
	$Sprite.frame = 0
	match character_info["name"]:
		"Protagonist":
			$Sprite.texture = luka_hurt
		"Mechanic":
			$Sprite.texture = sam_hurt
		"Foe":
			$Sprite.texture = soldier_hurt
		"Tanker":
			$Sprite.texture = thunder_hurt
		"Captain":
			$Sprite.texture = salvato_hurt
		"Berserk":
			$Sprite.texture = billy_hurt
		"Hammer":
			$Sprite.texture = dandara_hurt
		"Sniper":
			$Sprite.texture = morya_hurt
			
func hurt_animation():
#	yield(get_tree().create_timer(0.20), "timeout")
	$AnimationPlayer.play("Hurt")
	yield(get_tree().create_timer(0.40), "timeout")
	$AnimationPlayer.stop()
	change_to_jump_sprite()
	
func change_to_faint_sprite():
#	yield(get_tree().create_timer(0.48), "timeout")
	$Sprite.hframes = 15
	$Sprite.frame = 0
	match character_info["name"]:
		"Protagonist":
			$Sprite.texture = luka_faint
		"Mechanic":
			$Sprite.texture = sam_faint
		"Foe":
			$Sprite.texture = soldier_faint
		"Tanker":
			$Sprite.texture = thunder_faint
		"Captain":
			$Sprite.texture = salvato_faint
		"Berserk":
			$Sprite.texture = billy_faint
		"Hammer":
			$Sprite.texture = dandara_faint
		"Sniper":
			$Sprite.texture = morya_faint
			
func faint_animation():
#	yield(get_tree().create_timer(0.20), "timeout")
	$AnimationPlayer.play("Faint")
	yield(get_tree().create_timer(0.30), "timeout")
	$AnimationPlayer.stop()
	
func change_to_attack_sprite():
	$Sprite.frame = 0
	match character_info["name"]:
		"Protagonist":
			$Sprite.hframes = 27
			$Sprite.texture = luka_attack
		"Mechanic":
			$Sprite.hframes = 23
			$Sprite.texture = sam_attack
		"Foe":
			$Sprite.hframes = 23
			$Sprite.texture = soldier_attack
		"Tanker":
			$Sprite.hframes = 20
			$Sprite.texture = thunder_attack
		"Captain":
			$Sprite.hframes = 23
			$Sprite.texture = salvato_attack
		"Berserk":
			$Sprite.hframes = 27
			$Sprite.texture = billy_attack
		"Hammer":
			$Sprite.hframes = 27
			$Sprite.texture = dandara_attack
		"Sniper":
			$Sprite.hframes = 23
			$Sprite.texture = morya_attack
			
func attack_animation():
	$AnimationPlayer.play("Attack")
	yield(get_tree().create_timer(0.46), "timeout")
	$AnimationPlayer.stop()
	change_to_jump_sprite()
