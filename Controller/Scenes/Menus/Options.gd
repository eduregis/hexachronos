extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var resolutions = [Vector2(852,480),Vector2(1280,720)]

const maxres = 1
#onready var Global = $"/root/Global"

var resolutionTextureEnable = preload("res://Assets/Interface/Opcoes/BG/Resolucao.png")
var resolutionTextureDisable = preload("res://Assets/Interface/Opcoes/BG/ResolucaoDisabled.png")

# Called when the node enters the scene tree for the first time.
func _ready():
#	resetConfigs()
	
	$AnimationPlayer.play("ScreenEntering")
	$Musica/HMusica/HSlider.set_value(Global.MusicVolume)
	$SFX/HSFX/SFX_Slider.set_value(Global.sfxVolume)
	$Musica/HMusica/Label.set_text(String($Musica/HMusica/HSlider.get_value()))
	$SFX/HSFX/Label.set_text(String($SFX/HSFX/SFX_Slider.get_value()))
	
	pass # Replace with function body.


func _process(_delta):
	checkSize()
	checkreset()
	pass


func _on_HSlider_value_changed(value):
	$Musica/HMusica/Label.set_text(String(value))
	Global.MusicVolume=value
	
	pass # Replace with function body.


func _on_SFX_Slider_value_changed(value):
	$SFX/HSFX/Label.set_text(String(value))
	Global.sfxVolume=value
	pass # Replace with function body.





func _on_GrowRes_pressed():
	if Global.actualres<maxres:
		Global.actualres=Global.actualres+1
		
		setScreenSize()
	else:
		Global.actualres=maxres
	
	pass # Replace with function body.


func _on_LowRes_pressed():
	if Global.actualres>0:
		Global.actualres=Global.actualres-1
		
		setScreenSize()
	else:
		Global.actualres=0
	pass # Replace with function body.


func setScreenSize():
	$Resolucao/Label.set_text(String(resolutions[Global.actualres].x) + " X " + String(resolutions[Global.actualres].y) )
	OS.set_window_size(resolutions[Global.actualres])
	pass

func checkSize():
	if OS.window_fullscreen==false :
		$Modo/Full.set_disabled(false)
		$Modo/Window.set_disabled(true)
		$Resolucao/Sprite.set_texture(resolutionTextureEnable)
		$Modo/WindowModeLabel.set_text("WINDOWED")
#		$Resolucao/Label.set("custom_colors/default_color",Color(255,255,255,1))
		$Resolucao/GrowRes.set_disabled(false)
		$Resolucao/LowRes.set_disabled(false)
		if Global.actualres==0:
			$Resolucao/LowRes.set_disabled(true)
		elif Global.actualres==maxres:
			$Resolucao/GrowRes.set_disabled(true)
		
	
			
	elif OS.window_fullscreen==true:
		$Modo/Full.set_disabled(true)
		$Modo/Window.set_disabled(false)
		$Resolucao/LowRes.set_disabled(true)
		$Resolucao/GrowRes.set_disabled(true)
		$Resolucao/Sprite.set_texture(resolutionTextureDisable)
		$Modo/WindowModeLabel.set_text("FULLSCREEN")
		$Resolucao/Label.set_text("Auto")
#		$Resolucao/Label.set("custom_colors/default_color",Color(237,237,237,0.6))

	print(OS.window_fullscreen)
	print(Global.actualres)
	

func _on_Full_pressed():
	OS.window_fullscreen = true
	Global.actualres=1
	
	pass # Replace with function body.


func _on_Window_pressed():
	OS.window_fullscreen = false
	setScreenSize()
	
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="ScreenEntering":
		$AnimatedSprite.set_frame(0)
		$AnimatedSprite.play("default")
		$PageTitle.set_frame(0)
		$PageTitle.play("screenenter")
	elif anim_name=="ScreenOut":
		get_tree().change_scene("res://View/Scenes/Menus/Main Menu.tscn")
		pass	


func resetConfigs():
	OS.window_fullscreen = true
	$Musica/HMusica/HSlider.set_value(50)
	$SFX/HSFX/SFX_Slider.set_value(50)
	Global.actualres=1
	setScreenSize()
	$ResetOptions.set_disabled(true)
	$Musica/HMusica/Label.set_text(String($Musica/HMusica/HSlider.get_value()))
	$SFX/HSFX/Label.set_text(String($SFX/HSFX/SFX_Slider.get_value()))
	


func _on_ResetOptions_pressed():
	resetConfigs()
	pass # Replace with function body.

func checkreset():
	if $Musica/HMusica/HSlider.value!=50 or $SFX/HSFX/SFX_Slider.value!=50 or Global.actualres!=1 or OS.window_fullscreen!=true:
		$ResetOptions.set_disabled(false)
		pass


func _on_BackMenu_pressed():
	$AnimationPlayer.play_backwards("ScreenOut")
	$AnimatedSprite.set_frame(0)
	$AnimatedSprite.play("outscreen")
	$PageTitle.set_frame(0)
	$PageTitle.play("screenout")
	pass # Replace with function body.
