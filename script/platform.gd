extends StaticBody2D

@export var rocky := false

const rocky_texture  = preload("res://terrain/rocky_platform.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	if rocky:
		$Platform.texture = rocky_texture
