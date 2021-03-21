extends "res://Controller/Components/BasicCharacter.gd"

var sam_jump = preload("res://Assets/Animations/Sam - Pulo/Sam_Jump_SpriteSheet.png")

signal skill_range_on
signal skill_range_off

var skill01_btn_position

func buff_active(buff):
	match buff.effect:
		"defense":
			defense = int(defense * buff.value)
			buff_animation(["+ DEFESA"])
		"attack":
			attack = int(attack * buff.value)
			buff_animation(["+ ATAQUE"])
		"hit_rate":
			hit_rate = int(hit_rate * buff.value)
			buff_animation(["+ PRECISÃO"])
		"evasion":
			evasion = int(evasion * buff.value)
			buff_animation(["+ EVASÃO"])
		"taunt":
			taunt = int(taunt * buff.value)
		"berserk":
			attack = int(attack * buff.value)
			defense = int(defense * buff.value)
			buff_animation(["+ ATAQUE", "- DEFESA"])

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
			
func buff_animation(texts):
	for text in texts:
		$RichTextLabel.bbcode_text = "[center]" + String(text) + "[/center]"
		$TextTween.interpolate_property(
			$RichTextLabel, "modulate", Color(1,1,1,1), Color(1,1,1,0), 1, 
			Tween.TRANS_SINE, Tween.EASE_IN_OUT
		)
		$TextTween.interpolate_property(
			$RichTextLabel, "rect_position:y", damage_text_position.y, damage_text_position.y - 30, 1, 
			Tween.TRANS_SINE, Tween.EASE_IN_OUT
		)
		$TextTween.start()
		yield($TextTween, "tween_completed")


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
	$Sprite.texture = sam_jump
