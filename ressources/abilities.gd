extends Node

enum abilities {double_jump, long_side_dash, directional_dash, slow_fall, fly, crouch, none}

var functions : Dictionary = {
	abilities.double_jump: double_jump,
	abilities.slow_fall: slow_fall,
	abilities.fly: fly,
	abilities.crouch: crouch,
	abilities.long_side_dash: long_side_dash,
	abilities.directional_dash: directional_dash,
	abilities.none: none,
}

func none(_player : CharacterController):
	return

func double_jump(player : CharacterController):
	if (not player.is_on_floor()) and player.can_ability:
		player.can_ability = false
		player.update_state(player.states.jumping_state)

func slow_fall(player : CharacterController):
	if not player.is_on_floor():
		player.update_state(player.states.slow_falling_state)

func fly(player : CharacterController):
	if not player.is_on_floor():
		player.update_state(player.states.flying_state)

func crouch(player : CharacterController):
	if player.is_on_floor():
		player.update_state(player.states.crouching_state)

func long_side_dash(player : CharacterController):
	if player.can_ability:
		player.can_ability = false
		player.update_state(player.states.long_dashing_state)

func directional_dash(player : CharacterController):
	if player.can_ability:
		player.can_ability = false
		player.update_state(player.states.direction_dashing_state)
