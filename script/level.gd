extends Node2D

func win():
	$UI.win()
	get_tree().paused = true
