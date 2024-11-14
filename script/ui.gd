extends CanvasLayer

func win():
	$win.visible = true

func restart():
	get_tree().paused = false
	get_tree().reload_current_scene()
