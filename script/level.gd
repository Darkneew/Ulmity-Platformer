extends Node2D
class_name Level

@export var player1_position: Marker2D
@export var player2_position: Marker2D
@export var goal: Marker2D
@export var starting_terrain: Terrain = preload("res://ressources/terrains/default.tres")


signal taquin(callback)

func play_taquin(callback):
	taquin.emit(callback)
