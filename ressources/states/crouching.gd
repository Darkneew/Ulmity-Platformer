extends State

func init_state(player : CharacterController, _terrain : Terrain, _stats : Character) -> void:
	player.sprite.play("idling")
	player.scale.y /= 2

func get_speed(xspeed : float, terrain : Terrain, stats : Character) -> float :
	return stats.speed / terrain.slowness / 2

func get_slopiness(terrain : Terrain, _stats : Character) -> float :
	return terrain.slopiness / 3

func update_state(player : CharacterController, _terrain : Terrain, _stats : Character, keys : Keyset) -> void:
	if Input.is_action_pressed(keys.jump_key):
		player.scale.y *= 2
		player.update_state(player.states.jumping_state)
	elif not player.is_on_floor():
		player.scale.y *= 2
		player.update_state(player.states.falling_state)
	elif not Input.is_action_pressed(keys.ability_key):
		player.scale.y *= 2
		player.update_state(player.states.idling_state)
