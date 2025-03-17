extends State

func init_state(player : CharacterController, _terrain : Terrain, _stats : Character) -> void:
	player.sprite.play("walking")
	player.can_ability = true
	
func update_state(player : CharacterController, _terrain : Terrain, stats : Character, keys : Keyset) -> void:
	if Input.is_action_pressed(keys.jump_key):
		player.update_state(player.states.jumping_state)
	elif not player.is_on_floor():
		player.update_state(player.states.falling_state)
	elif abs(player.x_speed()) < 10:
		player.update_state(player.states.idling_state)
	elif Input.is_action_pressed(keys.ability_key):
		Abilities.functions[stats.ability].call(player)
