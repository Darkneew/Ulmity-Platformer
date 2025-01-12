extends State

func init_state(player : CharacterController, _terrain : Terrain, _stats : Character) -> void:
	player.sprite.play("walking")
	
func update_state(player : CharacterController, _terrain : Terrain, stats : Character) -> void:
	if Input.is_action_pressed(stats.jump_key):
		player.update_state(player.states.jumping_state)
	elif not player.is_on_floor():
		player.update_state(player.states.falling_state)
	elif abs(player.x_speed()) < 10:
		player.update_state(player.states.idling_state)
