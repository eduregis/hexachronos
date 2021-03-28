extends Node2D
var hp=0
var hpmax=100

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$HScrollBar.max_value=hpmax
	updatehpbar()
	
	
	pass # Replace with function body.

func updatehpbar():
	$TextureProgress.value=0
	
	var hp_percentage=(hp/hpmax)*100
	
	$TextureProgress.value=clamp(hp_percentage,0,100)
	
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HScrollBar_value_changed(value):
	
	hp=value
	updatehpbar()
	pass # Replace with function body.
