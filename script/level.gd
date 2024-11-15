extends Node2D

func win():
	$UI.win()
	get_tree().paused = true

func heart_update(nb):
	$UI.update_hearts(nb)
