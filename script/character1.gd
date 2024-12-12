extends CharacterBody2D 

enum State {Walking, Falling, Floating, Jumping, StayingStill}

signal heart_update(nb: int)

const STRENGTH = 1000
const SPEED = 1300.0
const GRAVITY : float = 2000
const JUMP_VELOCITY : float = 2000

var direction: Vector2 = Vector2.DOWN
var heart: int 
var gravity: float 

@onready var sprite : Node = $sprite

@export var state: State: 
	get: 
		return state
	set(value):
		state = value
		if sprite == null: 
			return
		match value:
			State.Walking:
				sprite.play("running")
				gravity = GRAVITY
			State.Falling:
				sprite.play("falling")
				gravity = GRAVITY * 1.3 
			State.Floating:
				sprite.play("floating")
				gravity = GRAVITY * 0.7 
			State.Jumping:
				sprite.play("jumping")
				gravity = GRAVITY 
				$Sounds/JumpSound.play()
				velocity = direction.rotated(-PI/2) * x_speed() - JUMP_VELOCITY * direction
			State.StayingStill:
				sprite.play("idling")
				gravity = GRAVITY
			_: 
				print("WARNING: unknown state")
				print(value)

func update_state():
	if state == State.Walking:
		if not is_on_floor():
			state = State.Falling
		elif x_speed() == 0:
			state = State.StayingStill
	elif state == State.Falling:
		if is_on_floor():
			if x_speed() == 0:
				state = State.StayingStill
			else: 
				state = State.Walking
	elif state == State.Floating:
		if y_speed() > 0.2 * JUMP_VELOCITY:
			state = State.Falling
	elif state == State.Jumping:
		if y_speed() > - 0.2 * JUMP_VELOCITY:
			state = State.Floating
	elif state == State.StayingStill:
		if not is_on_floor():
			state = State.Falling
		elif not x_speed() == 0:
			state = State.Walking
	else: 
		print("WARNING: unknown state")
		print(state)

func change_direction(angle : float):
	up_direction = - Vector2.DOWN.rotated(angle / 180 * PI)
	direction = Vector2.DOWN.rotated(angle / 180 * PI)
	rotation = angle / 180 * PI
	state = State.Floating

func hurt (_x):
	$Sounds/HurtSound.play()
	heart -= 1
	heart_update.emit(heart)
	if heart == 0:
		get_tree().reload_current_scene()

func y_speed():
	return direction.dot(velocity)

func x_speed():
	return direction.rotated(-PI/2).dot(velocity)

func _ready():
	gravity = GRAVITY
	heart = 3
	state = State.StayingStill

func _process(delta):
	# Applying gravity
	velocity += direction * gravity * delta
	# Jump
	if Input.is_action_just_pressed("ui_accept") and (state == State.Walking or state == State.StayingStill):
		state = State.Jumping

	# Movement 
	var input = Input.get_axis("ui_left", "ui_right")
	sprite.flip_h = (input < 0)
	velocity = direction.rotated(-PI/2) * input * SPEED + y_speed() * direction
	
	# Collision
	move_and_slide()
	for i in range(get_slide_collision_count()):
		var c = get_slide_collision(i)
		if c.get_collider().collision_layer & 16:
			c.get_collider().push(-c.get_normal() * STRENGTH)
			
	update_state()
