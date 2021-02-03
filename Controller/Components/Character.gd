extends "res://Controller/Components/BasicCharacter.gd"

signal skill_range_on
signal skill_range_off

var skill01_btn_position

func show_skill_menu():
	yield(get_tree().create_timer(0.5), "timeout")
	$SkillMenu.visible = true
	$SkillMenu/Skill_01Button.modulate = Color(1, 1, 1, 0)
	skill01_btn_position = $SkillMenu/Skill_01Button.position
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
	pass
	
func _on_Skill_01ButtonHitBox_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		match character_info["name"]:
			"Tanker":
				emit_signal("skill", index, 2)
			"Mechanic":
				emit_signal("skill", index, 2)
func _on_Skill_01ButtonHitBox_mouse_entered():
	$SkillMenu/Skill_01Button/Sprite.scale = Vector2(0.67, 0.67)
	emit_signal("skill_range_on", index, 2)

func _on_Skill_01ButtonHitBox_mouse_exited():
	$SkillMenu/Skill_01Button/Sprite.scale = Vector2(0.63, 0.63)
	emit_signal("skill_range_off", index, 2)

func _on_SkillMenuTween_tween_all_completed():
	$SkillMenu/Skill_01Button.position = skill01_btn_position
