extends Resource
class_name Character

## Number of lives of the player
@export var lives : int = 3
## Ability of the character
@export var ability : Abilities.abilities = Abilities.abilities.none

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
## Speed at which the player get knocked back when hurt, proportional to his previous speed
@export var knockback : float = 1.5
## Time during which the player has less mobility after being knocked back, in seconds
@export var rehab_time : float = 0.2

@export_group("Appearance")
## Width of the character
@export_range(0,2) var width : float = 1
## Height of the character
@export_range(0,2) var height : float = 1
## Color of the character 
@export var color : Color = Color.WHITE
## Description 
@export var description : String = "Just a lambda person"
## Name 
@export var name : String = "Bob"
## Ability name 
@export var ability_name : String = "None"
