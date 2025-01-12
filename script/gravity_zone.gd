extends Area2D

func _on_body_entered(body: CharacterController):
	body.update_terrain(load("res://ressources/terrains/left_gravity_field.tres"))

func _on_body_exited(body):
	body.update_terrain(load("res://ressources/terrains/default.tres"))
