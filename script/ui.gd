extends CanvasLayer

const HEARTS = [preload("res://UI/coeur_1.png"), preload("res://UI/coeur_2.png"), preload("res://UI/coeur_3.png")]

const BUTTON = preload("res://scenes/dialogue_button.tscn")

@onready var dialogue_box: BoxContainer = $dialogue/BoxContainer

var _restart: Callable

func win():
	$win.visible = true

func restart():
	$RestartButton.release_focus()
	_restart.call()

func pause():
	if get_tree().paused:
		if $PauseLabel.visible:
			$PauseLabel.visible = false
			get_tree().paused = false
	else:
		if $PauseLabel.visible:
			get_tree().paused = true
		else: 
			$PauseLabel.visible = true
			get_tree().paused = true
	$PauseButton.release_focus()

func update_hearts(nb: int):
	if nb == 0:
		$Hearts.texture = null 
	elif nb < 4:
		$Hearts.texture = HEARTS[nb - 1]
		
func add_button(text, action):
	var button = BUTTON.instantiate()
	button.text = text
	dialogue_box.add_child(button)
	button.button_down.connect(action)
	
func reset_button():
	while dialogue_box.get_child_count() > 0:
		dialogue_box.remove_child(dialogue_box.get_child(0))
