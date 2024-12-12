extends Area2D

@export var angle: float = 90

func _on_body_entered(body):
	body.change_direction(angle)

func _on_body_exited(body):
	body.change_direction(0)
