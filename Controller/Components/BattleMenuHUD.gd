extends Node2D

var ArrowSlot = preload("res://View/Components/ArrowSlot.tscn")

signal attackSequence

var slots = []
var arrowSequence = []
var arrowIndex = 0
export var maxSlots = 5

func _ready():
	startMenu()
	toggleMenu($MainButtons)
	for i in range(0, maxSlots):
		var slot = ArrowSlot.instance()
		slot.set_position(Vector2(105 + 53*i, -37))
		slots.append(slot)
		$AttackButtons.add_child(slot)
	
func startMenu():	
	$Background.modulate = Color(1,1,1,0)
	$AttackButtons.modulate = Color(1,1,1,0)
	$AttackButtons.visible = false
	var tween = get_node("DismissTween")
	tween.interpolate_property(
		$Background, "modulate", Color(1, 1, 1, 0) , Color(1, 1, 1, 1), 0.4, 
		Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	var xPosition = $Background.position.x
	tween.interpolate_property(
		$Background, "position:x", xPosition - 100 , xPosition, 0.4, 
		Tween.TRANS_QUAD, Tween.EASE_IN
	)
	tween.start()

func dismissMenu(menu):
	var tween = get_node("DismissTween")
	tween.interpolate_property(
		menu, "modulate", Color(1, 1, 1, 1) , Color(1, 1, 1, 0), 0.4, 
		Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	tween.interpolate_property(
		menu, "position:x", menu.position.x , menu.position.x - 100, 0.4, 
		Tween.TRANS_QUAD, Tween.EASE_IN
	)
	tween.start()
	yield(tween, "tween_completed")
	menu.visible = false
	tween.interpolate_property(
		menu, "position:x", menu.position.x , menu.position.x + 100, 0.01, 
		Tween.TRANS_QUAD, Tween.EASE_IN
	)
	tween.start()

func toggleMenu(menu):
	menu.visible = true
	menu.modulate = Color(1,1,1,0)
	var tween = get_node("ToggleTween")
	tween.interpolate_property(
		menu, "modulate", Color(1, 1, 1, 0) , Color(1, 1, 1, 1), 0.4, 
		Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	var xPosition = menu.position.x
	tween.interpolate_property(
		menu, "position:x", xPosition - 100 , xPosition, 0.4, 
		Tween.TRANS_QUAD, Tween.EASE_IN
	)
	tween.start()

func _on_AttackButton_pressed():
	dismissMenu($MainButtons)
	yield(get_tree().create_timer(0.2), "timeout")
	toggleMenu($AttackButtons)
	print("attack")

func _on_BlockButton_pressed():
	dismissMenu($MainButtons)
	yield(get_tree().create_timer(0.2), "timeout")
	print("block")

func _on_HabilityButton_pressed():
	dismissMenu($MainButtons)
	yield(get_tree().create_timer(0.2), "timeout")
	print("hability")

func _on_BagButton_pressed():
	dismissMenu($MainButtons)
	yield(get_tree().create_timer(0.2), "timeout")
	print("bag")

func _on_AnalysisButton_pressed():
	dismissMenu($MainButtons)
	yield(get_tree().create_timer(0.2), "timeout")
	print("analysis")

func _on_RunButton_pressed():
	dismissMenu($MainButtons)
	yield(get_tree().create_timer(0.2), "timeout")
	print("run")
	
func _on_AttackBackButton_pressed():
	dismissMenu($AttackButtons)
	yield(get_tree().create_timer(0.2), "timeout")
	toggleMenu($MainButtons)
	print("back")

func _on_ArtsButton_pressed():
	print("arts")

func arrowPressed(direction):
	if arrowIndex < maxSlots:
		slots[arrowIndex].arrowTo(direction)
		arrowSequence.append(direction)
		if arrowIndex + 1 != maxSlots:
			arrowIndex += 1

func _on_ArrowUpButton_pressed():
	arrowPressed("up")
	print("arrow up attack")

func _on_ArrowLeftButton_pressed():
	arrowPressed("left")
	print("arrow left attack")

func _on_ArrowRightButton_pressed():
	arrowPressed("right")
	print("arrow right attack")

func _on_ArrowDownButton_pressed():
	arrowPressed("down")
	print("arrow down attack")

func _on_CleanButton_pressed():
	arrowSequence = []
	for i in range(0, arrowIndex + 1):
		slots[arrowIndex - i].arrowTo("empty")
		yield(get_tree().create_timer(0.03), "timeout")
	arrowIndex = 0
	print("clean")

func _on_AttackPlayButton_pressed():
	var tween = get_node("DismissTween")
	tween.interpolate_property(
		self, "modulate", Color(1, 1, 1, 1) , Color(1, 1, 1, 0), 0.4, 
		Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	var xPosition = self.position.x
	tween.interpolate_property(
		self, "position:x", xPosition , xPosition - 100, 0.4, 
		Tween.TRANS_QUAD, Tween.EASE_IN
	)
	tween.start()
	yield(tween, "tween_completed")
	print("play")
	queue_free()
	

