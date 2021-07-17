extends Node2D

# control variables
export var character_info = {}
export var team = ""
export var defeated = false
export var inanimated = false
var able_move = true
var able_attack = true
var able_block = true
var able_skill = true

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

var damage_text_position

func _ready():
	set_stats()
	$RichTextLabel.modulate = Color(1,1,1,0)
	$Sprite.modulate = Color(1,1,1,0)
	set_sprite()
	if team == "foe":
		$Sprite.flip_h = true
	damage_text_position = $RichTextLabel.rect_position
	var tween = get_node("Tween")
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
	
func set_sprite():
	pass

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

func move_to():
	jump_animation()

func jump_animation():
	pass

func change_to_hurt_sprite():
	pass
	
func hurt_animation():
	pass
	
func change_to_faint_sprite():
	pass
	
func faint_animation():
	pass
