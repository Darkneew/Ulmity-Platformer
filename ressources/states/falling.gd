extends State

func init_state(player : CharacterController, _terrain : Terrain, _stats : Character) -> void:
	player.sprite.play("falling")

func get_gravity(_player: CharacterController, terrain : Terrain, _stats : Character) -> float :
	return terrain.fall_gravity_factor * terrain.gravity

func get_slopiness(terrain : Terrain, stats : Character) -> float :
	return terrain.midair_delay + stats.midair_clumsiness

func update_state(player : CharacterController, terrain : Terrain, _stats : Character) -> void:
	if player.is_on_floor():
		player.update_state(player.states.idling_state)
	elif player.y_speed() < player.last_jump_velocity * terrain.midair_limit:
		player.update_state(player.states.floating_state)
