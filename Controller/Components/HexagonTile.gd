extends Node2D

var default_floor = preload("res://Assets/Floors/State=Default, Action=None.png")
var occupied_floor = preload("res://Assets/Floors/State=Ocupado, Action=None.png")
var path_floor = preload("res://Assets/Floors/State=Available, Action=Move.png")
var attack_floor = preload("res://Assets/Floors/State=Available, Action=Attack.png")
var skill_floor = preload("res://Assets/Floors/State=Available, Action=Hability.png")

export var tile_index = Vector2.ZERO
var occupied = false
var path = false

signal path_move_to

func _ready():
	scale = Vector2(0.83, 1)
	$Sprite.scale = Vector2.ZERO
	$Sprite.texture = default_floor
	
	$TileHitBox/HitBox.tile_index = tile_index
	$TileHitBox/HitBox.tile_position = position
	$TileHitBox/HitBox.connect("path_move", self, "path_move_to")
	yield(get_tree().create_timer((tile_index.x + tile_index.y) * 0.1), "timeout")
	$Tween.interpolate_property(
		$Sprite, "scale", Vector2.ZERO, Vector2(0.7, 0.7), 0.4, 
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT
	)
	$Tween.start()

func path_move_to():
	emit_signal("path_move_to", tile_index, position)
	
func remove_path():
	path = false
	if !occupied:
		$Sprite.texture = default_floor
	else:
		$Sprite.texture = occupied_floor
	$Sprite.modulate = Color(1, 1, 1)
		
func char_tile():
	yield(get_tree().create_timer((tile_index.x + tile_index.y) * 0.1), "timeout")
	$Sprite.texture = occupied_floor
	occupied = true

func path_tile(path_index):
	if path_index != -1:
		yield(get_tree().create_timer(path_index * 0.02), "timeout")
		$Sprite.texture = path_floor
	else:
		$Sprite.texture = path_floor
	if occupied:
		$Sprite.modulate = Color(0.5, 0.5, 0.5)
	path = true
	
func attack_tile(path_index):
	if path_index != -1:
		yield(get_tree().create_timer(path_index * 0.02), "timeout")
		$Sprite.texture = attack_floor
	else:
		$Sprite.texture = attack_floor
	if occupied:
		$Sprite.modulate = Color(0.5, 0.5, 0.5)
	path = true
	
func skill_tile(path_index):
	if path_index != -1:
		yield(get_tree().create_timer(path_index * 0.02), "timeout")
		$Sprite.texture = skill_floor
	else:
		$Sprite.texture = skill_floor
	if occupied:
		$Sprite.modulate = Color(0.5, 0.5, 0.5)
	path = true

func _on_TileHitBox_mouse_entered():
	if !occupied:
		$Sprite.modulate = Color(0.7, 0.7, 0.7)


func _on_TileHitBox_mouse_exited():
	if !occupied:
		$Sprite.modulate = Color(1, 1, 1)
