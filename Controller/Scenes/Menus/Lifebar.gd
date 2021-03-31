extends Node2D
var hp = 0
var hpMax = 100
export var battle_id = 0
export var char_name = ""

func _ready():
	$HScrollBar.max_value = hpMax
	scale = Vector2(0.6, 0.6)
	print(char_name)
	hp = hpMax
	set_portrait()
	updateHpBar()

func enlarge():
	scale = Vector2(0.7, 0.7)
	
func retract():
	scale = Vector2(0.6, 0.6)

func set_portrait():
	match char_name:
		"Protagonist":
			$TextureProgress.texture_over = Global.lifebar_morya
		"Mechanic":
			$TextureProgress.texture_over = Global.lifebar_sam
		"Tanker":
			$TextureProgress.texture_over = Global.lifebar_borell
		"Berserk":
			$TextureProgress.texture_over = Global.lifebar_billy
		"Sniper":
			$TextureProgress.texture_over = Global.lifebar_morya
		"Hammer":
			$TextureProgress.texture_over = Global.lifebar_dandara
		"Captain":
			$TextureProgress.texture_over = Global.lifebar_salvato
		"Foe":
			$TextureProgress.texture_over = Global.lifebar_morya

func updateHp(value):
	hp = value
	updateHpBar()

func updateHpBar():
	var hp_percentage = (float(hp)/float(hpMax))*100
	$TextureProgress.value = clamp(hp_percentage,0,100)


func _on_HScrollBar_value_changed(value):
#	hp = value
#	updateHpBar()
	pass # Replace with function body.
