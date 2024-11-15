extends Area2D

signal end_game

func player_entered (_x):
	end_game.emit()

func area_entered(_x):
	$Text.visible = true
	
func area_exited(_x):
	$Text.visible = false
