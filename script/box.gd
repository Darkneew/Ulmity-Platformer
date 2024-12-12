extends RigidBody2D

@onready var timer : Timer = $PushTimer

func push(vec: Vector2):
	if timer.time_left > 0:
		return
	apply_central_impulse(vec)
	timer.start()
