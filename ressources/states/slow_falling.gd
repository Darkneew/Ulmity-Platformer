extends State

func init_state(player : CharacterController, _terrain : Terrain, _stats : Character) -> void:
	player.sprite.play("floating")

func get_gravity(player: CharacterController, terrain : Terrain, _stats : Character) -> float :
	var fac = 3
	if player.y_speed() > 0 :
		fac /= 9
	return terrain.midair_gravity_factor * terrain.gravity * fac

func get_slopiness(terrain : Terrain, stats : Character) -> float :
	return terrain.midair_delay + stats.midair_clumsiness

func update_state(player : CharacterController, _terrain : Terrain, _stats : Character, keys : Keyset) -> void:
	if player.is_on_floor():
		player.update_state(player.states.idling_state)
	elif not Input.is_action_pressed(keys.ability_key):
		player.update_state(player.states.floating_state)

func get_speed(xspeed : float, terrain : Terrain, stats : Character) -> float :
	return stats.speed / terrain.slowness * 1.1

func process(delta, player : CharacterController, terrain : Terrain, stats : Character, keys : Keyset):
	# Movement
	var yspeed = lerpf(player.y_speed(), stats.speed / 5, min(1, delta*3))
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
	
