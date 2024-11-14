extends Area2D

signal end_game

func player_entered (x):
	end_game.emit()
