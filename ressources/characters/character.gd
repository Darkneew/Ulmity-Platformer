extends Resource
class_name Character

## Number of lives of the player
@export var lives : int = 3

@export_group("Movement")
## Speed of the player
@export var speed : float = 1300
## Minimal jump velocity, if the jump key is immediatly released
@export var min_jump_velocity : float = 500
## Maximal jump velocity, if the jump key is never released
@export var max_jump_velocity : float = 1800
## Time to press the jump key to get the highest jump possible, in milliseconds
@export var allowed_jumping_time : float = 200
## How much agility can be exerted midair. Delay needed to do a turn midair, in milliseconds.
@export var midair_clumsiness : float = 500

@export_group("Interactions")
## Strength to push objects
@export var push_strength : float = 1000
## Layer(s) the character can interact with
@export var interaction_layer : int = 16

@export_group("Controls")
@export var jump_key: StringName = "ui_accept"
@export var left_key: StringName = "ui_left"
@export var right_key: StringName = "ui_right"
@export var pause_key: StringName = "p1-pause"
@export var restart_key: StringName = "p1-restart"
