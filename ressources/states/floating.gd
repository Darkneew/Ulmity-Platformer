extends State

func init_state(player : CharacterController, _terrain : Terrain, _stats : Character) -> void:
	player.sprite.play("floating")

func get_gravity(player: CharacterController, terrain : Terrain, _stats : Character) -> float :
	var yspeed = player.y_speed()
	if yspeed < 0:
		return terrain.gravity * lerpf(1, terrain.midair_gravity_factor, 1 + yspeed/(terrain.midair_limit*player.last_jump_velocity))
	else:
		return terrain.gravity * lerpf(terrain.fall_gravity_factor, terrain.midair_gravity_factor, 1 - yspeed/(terrain.midair_limit*player.last_jump_velocity))

func get_slopiness(terrain : Terrain, stats : Character) -> float :
	return terrain.midair_delay + stats.midair_clumsiness

func update_state(player : CharacterController, terrain : Terrain, _stats : Character) -> void:
	if player.is_on_floor():
		player.update_state(player.states.idling_state)
	elif player.y_speed() > player.last_jump_velocity * terrain.midair_limit:
		player.update_state(player.states.falling_state)
