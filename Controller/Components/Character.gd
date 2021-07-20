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
		"BasicSoldier":
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

func jump_animation():
	$AnimationPlayer.play("Jump")
	yield(get_tree().create_timer(0.64), "timeout")
	$AnimationPlayer.stop()
	

func change_to_hurt_sprite():
#	yield(get_tree().create_timer(0.48), "timeout")
	$Sprite.hframes = 20
	$Sprite.frame = 0
	match character_info["name"]:
		"Protagonist":
			$Sprite.texture = luka_hurt
		"Mechanic":
			$Sprite.texture = sam_hurt
		"BasicSoldier":
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
		"BasicSoldier":
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
		"BasicSoldier":
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
