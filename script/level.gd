extends Node2D

signal next_level()

func win():
	$UI.win()
	get_tree().paused = true
	get_tree().create_timer(3).timeout.connect(change_level)
	
func change_level():
	get_tree().paused = false
	next_level.emit()

func heart_update(nb):
	$UI.update_hearts(nb)
