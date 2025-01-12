extends Resource
class_name Terrain 

## Direction of the gravity
@export var gravity_direction : Vector2 = Vector2.DOWN

@export_group("Ground movement")
## How much the max speed of the player is decreased
@export var slowness : float = 1
## Slopiness of the ground. Higher value will give less reactivity. The value is the time in milliseconds it takes to turn.
@export var slopiness : float = 100
## Maximum lateral speed for the player when crouching, in purcentage of the usual speed
@export_range(0,1) var crouch_speed_factor : float = 0.7

@export_group("Air movement")
## Delay of the player to turn while midair. How unwell can the player change its direction when in the air. The value is the time in milliseconds it takes to turn.
@export var midair_delay : float = 200
## Gravity for the player
@export var gravity : float = 2000
## Gravity multiplier for the player when at the highest point of his jump, allows for a more pleasant jump
@export_range(0,1) var midair_gravity_factor : float = 0.3
## Gravity multiplier for the player when falling, allows for a more pleasant jump
@export_range(0,5) var fall_gravity_factor : float = 1.7
## Limit defining when is the highest point of the jump, in purcentage of the initial velocity of the jump. Lower values will result in more natural jumps, higher values will give more "flying" jumps
@export_range(0,1) var midair_limit : float = 0.3
## Downward maximal velocity for the player
@export var max_fall_speed : float = 3000
