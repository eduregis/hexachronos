extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("FadeIn")
	pass # Replace with function body.


var imgid=0
var buttonid = [
	"HBoxContainer/SlideButton1","HBoxContainer/SlideButton2",
	"HBoxContainer/SlideButton3","HBoxContainer/SlideButton4",
	"HBoxContainer/SlideButton5","HBoxContainer/SlideButton6"]






func _on_SlideButton1_toggled(_button_pressed):
	$Timer.stop()
	imgid=0
	$AnimationPlayer.play("FadeOut")
	pass # Replace with function body.


func _on_SlideButton2_toggled(_button_pressed):
	$Timer.stop()
	imgid=1
	$AnimationPlayer.play("FadeOut")
	pass # Replace with function body.


func _on_SlideButton3_toggled(_button_pressed):
	$Timer.stop()
	imgid=2
	$AnimationPlayer.play("FadeOut")
	
	pass # Replace with function body.


func _on_SlideButton4_toggled(_button_pressed):
	$Timer.stop()
	imgid=3
	$AnimationPlayer.play("FadeOut")
	
	pass # Replace with function body.


func _on_SlideButton5_toggled(_button_pressed):
	$Timer.stop()
	imgid=4
	$AnimationPlayer.play("FadeOut")
	
	pass # Replace with function body.


func _on_SlideButton6_toggled(_button_pressed):
	$Timer.stop()
	imgid=5
	$AnimationPlayer.play("FadeOut")
	pass # Replace with function body.


func _on_Timer_timeout():
	if imgid<5:
		imgid=imgid+1
	else:
		imgid=0
	get_node(buttonid[imgid]).set_pressed(true)
	
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="FadeOut":
		$Characters/AnimatedSprite.frame=imgid
		$AnimationPlayer.play("FadeIn")
	else:
		$Timer.start()
	
	pass # Replace with function body.
