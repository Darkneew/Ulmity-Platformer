extends State

func init_state(player : CharacterController, _terrain : Terrain, _stats : Character) -> void:
	player.sprite.play("floating")

func get_speed(xspeed : float, terrain : Terrain, stats : Character) -> float :
	return stats.speed / terrain.slowness / 4

func process(delta, player : CharacterController, terrain : Terrain, stats : Character, keys : Keyset):
	# Movement
	var yspeed = lerpf(player.y_speed(), -stats.speed / 4, min(1, delta*2))
	var xspeed = player.x_speed()
	var target = Input.get_axis(keys.left_key, keys.right_key) * get_speed(xspeed, terrain, stats)
	player.sprite.flip_h = (target < 0)
	if abs(xspeed) > get_speed(xspeed, terrain, stats):
		xspeed = lerpf(xspeed, get_speed(xspeed, terrain, stats)*sign(xspeed), delta*2)
	if target - xspeed > 0:
		xspeed = min(xspeed + delta*get_acceleration(xspeed, terrain, stats, player.knocked_back), target)
	if target - xspeed < 0:
		xspeed = max(xspeed - delta*get_acceleration(xspeed, terrain, stats, player.knocked_back), target)
	player.velocity = terrain.gravity_direction * yspeed + terrain.gravity_direction.rotated(-PI/2) * xspeed

	player.move_and_slide()
	
	update_state(player, terrain, stats, keys)
	
func get_slopiness(terrain : Terrain, stats : Character) -> float :
	return terrain.midair_delay + stats.midair_clumsiness + 1000

func update_state(player : CharacterController, _terrain : Terrain, _stats : Character, keys : Keyset) -> void:
	if Input.is_action_just_released(keys.ability_key):
		player.update_state(player.states.floating_state)
	if player.is_on_floor():
		player.update_state(player.states.idling_state)
