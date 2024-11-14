extends Node2D

@export var color: Color = Color(1, 0.43, 0.41, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	$petals.modulate = color

