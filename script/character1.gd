extends CharacterBody2D 

enum State {Walking, Falling, Floating, Jumping, StayingStill}

signal heart_update(nb: int)

const STRENGTH = 1000
const SPEED = 1300.0
const GRAVITY : float = 2000
const JUMP_VELOCITY : float = 2000

var heart: int 
var gravity: float 

@export var state: State: 
	get: 
		return state
	set(value):
		state = value
		if sprite == null: 
			return
		if value == State.Walking:
			sprite.play("running")
			gravity = GRAVITY
		elif value == State.Falling:
			sprite.play("falling")
			gravity = GRAVITY * 1.3 
		elif value == State.Floating:
			sprite.play("floating")
			gravity = GRAVITY * 0.7 
		elif value == State.Jumping:
			sprite.play("jumping")
			gravity = GRAVITY 
			$Sounds/JumpSound.play()
			velocity.y = - JUMP_VELOCITY
		elif value == State.StayingStill:
			sprite.play("idling")
			gravity = GRAVITY
		else: 
			print("WARNING: unknown state")
			print(value)

@onready var sprite : Node = $sprite

func update_state():
	if state == State.Walking:
		if not is_on_floor():
			state = State.Falling
		elif velocity.x == 0:
			state = State.StayingStill
	elif state == State.Falling:
		if is_on_floor():
			if velocity.x == 0:
				state = State.StayingStill
			else: 
				state = State.Walking
	elif state == State.Floating:
		if velocity.y > 0.2 * JUMP_VELOCITY:
			state = State.Falling
	elif state == State.Jumping:
		if velocity.y > - 0.2 * JUMP_VELOCITY:
			state = State.Floating
	elif state == State.StayingStill:
		if not is_on_floor():
			state = State.Falling
		elif not velocity.x == 0:
			state = State.Walking
	else: 
		print("WARNING: unknown state")
		print(state)

func hurt (_x):
	$Sounds/HurtSound.play()
	heart -= 1
	heart_update.emit(heart)
	if heart == 0:
		get_tree().reload_current_scene()

func _ready():
	gravity = GRAVITY
	heart = 3
	state = State.StayingStill

func _process(delta):
	# Applying gravity
	velocity.y += gravity * delta
	
	# Jump
	if Input.is_action_just_pressed("ui_accept") and (state == State.Walking or state == State.StayingStill):
		state = State.Jumping
		
	# Movement 
	var direction = Input.get_axis("ui_left", "ui_right")
	sprite.flip_h = (direction < 0)
	velocity.x = direction * SPEED
	
	# Collision
	move_and_slide()
	for i in range(get_slide_collision_count()):
		var c = get_slide_collision(i)
		if c.get_collider().collision_layer & 16:
			c.get_collider().push(-c.get_normal() * STRENGTH)
			
	update_state()
