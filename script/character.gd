extends CharacterBody2D

const SPEED = 1300.0
const JUMP_VELOCITY = 2000.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = 2000

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if absf(velocity.y) < 0.2 * JUMP_VELOCITY:
			velocity.y += gravity * delta * 0.7
		else:
			velocity.y += gravity * delta 

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = - JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		$sprite.play("running")
		$sprite.flip_h = (direction < 0)
		velocity.x = direction * SPEED
	else:
		$sprite.play("idling")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		
	if not is_on_floor():
		if velocity.y < 0:
			$sprite.play("up")
		else: 
			$sprite.play("down")
	move_and_slide()
