extends CharacterBody2D
class_name CharacterController

@export var terrain : Terrain
@export var stats : Character
@export var state : State

var states = {
	"idling_state": load("res://ressources/states/idling.tres"),
	"floating_state": load("res://ressources/states/floating.tres"),
	"falling_state": load("res://ressources/states/falling.tres"),
	"jumping_state": load("res://ressources/states/jumping.tres"),
	"walking_state": load("res://ressources/states/walking.tres")
}

signal heart_update(nb: int)
var heart: int

@onready var sprite : AnimatedSprite2D = $sprite
@onready var jump_sound : AudioStreamPlayer = $Sounds/JumpSound

var last_jump_velocity : float

func y_speed():
	return terrain.gravity_direction.dot(velocity)

func x_speed():
	return terrain.gravity_direction.rotated(-PI/2).dot(velocity)

func _ready():
	heart = stats.lives
	last_jump_velocity = stats.max_jump_velocity

func update_state(_state: State):
	state = _state
	_state.init_state(self, terrain, stats)

func _process(delta):
	state.process(delta, self, terrain, stats)

func update_terrain(_terrain: Terrain):
	if _terrain.gravity_direction.dot(terrain.gravity_direction) < 1:
		up_direction = - _terrain.gravity_direction
		rotation = _terrain.gravity_direction.angle() - PI/2
		update_state(states.floating_state)
	terrain = _terrain
	
func get_damage(_x):
	$Sounds/HurtSound.play()
	heart -= 1
	heart_update.emit(heart)
	if heart == 0:
		get_tree().reload_current_scene.call_deferred()
