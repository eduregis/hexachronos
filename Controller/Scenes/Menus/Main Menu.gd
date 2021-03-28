extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var scenes = ["res://View/Scenes/Act1_Scene2.tscn",null,null,"res://View/Scenes/Menus/Options.tscn"]
var scenetochange = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("ScreenEnter")
	
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="ScreenEnter":
		$AnimatedSprite.play("default")
	elif anim_name=="ScreenOut" or anim_name=="NewGameTransition":
		get_tree().change_scene(scenes[scenetochange])
	pass # Replace with function body.





func _on_Sair_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_Opcoes_pressed():
	scenetochange=3
	$AnimationPlayer.play_backwards("ScreenOut")
	$AnimatedSprite.set_frame(0)
	$AnimatedSprite.play("outscreen")
	pass # Replace with function body.


func _on_Creditos_pressed():
	pass # Replace with function body.


func _on_Continuar_pressed():
	pass # Replace with function body.


func _on_Novo_Jogo_pressed():
	scenetochange=0
	$AnimationPlayer.play_backwards("NewGameTransition")
	$AnimatedSprite.set_frame(0)
	$AnimatedSprite.play("outscreen")
	pass # Replace with function body.
