extends Area2D

@export var terrain_inside : Terrain
@export var terrain_outside : Terrain

func _on_body_entered(body):
	body.update_terrain(terrain_inside)

func _on_body_exited(body):
	body.update_terrain(terrain_outside)
