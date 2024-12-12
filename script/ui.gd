extends CanvasLayer

const HEARTS = [preload("res://UI/coeur_1.png"), preload("res://UI/coeur_2.png"), preload("res://UI/coeur_3.png")]

func win():
	$win.visible = true

func restart():
	get_tree().paused = false
	$RestartButton.release_focus()
	get_tree().reload_current_scene()

func pause():
	if get_tree().paused:
		$PauseLabel.visible = false
		get_tree().paused = false
	else:
		$PauseLabel.visible = true
		get_tree().paused = true
	$PauseButton.release_focus()

func update_hearts(nb: int):
	if nb == 0:
		$Hearts.texture = null 
	elif nb < 4:
		$Hearts.texture = HEARTS[nb - 1]
