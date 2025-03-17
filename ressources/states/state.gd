extends Resource
class_name State

func get_gravity(_player: CharacterController, terrain : Terrain, _stats : Character) -> float :
	return terrain.gravity

func get_speed(xspeed : float, terrain : Terrain, stats : Character) -> float :
	return max(abs(xspeed),stats.speed / terrain.slowness)

func get_slopiness(terrain : Terrain, _stats : Character) -> float :
	return terrain.slopiness

func get_acceleration(xspeed : float, terrain : Terrain, stats : Character, knocked_back) -> float :
	var fac = 1
	if knocked_back:
		fac = 10
	return 2000*get_speed(xspeed, terrain, stats)/get_slopiness(terrain, stats)/fac

func init_state(_player : CharacterController, _terrain : Terrain, _stats : Character):
	pass

func process(delta, player : CharacterController, terrain : Terrain, stats : Character, keys : Keyset):
	
	# Movement
	var yspeed = min(player.y_speed() + get_gravity(player, terrain, stats) * delta, terrain.max_fall_speed)
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

	# Collision
	player.move_and_slide()
	for i in range(player.get_slide_collision_count()):
		var c = player.get_slide_collision(i)
		if c.get_collider().collision_layer & stats.interaction_layer:
			c.get_collider().push(-c.get_normal() * stats.push_strength)
	
	update_state(player, terrain, stats, keys)

func update_state(_player : CharacterController, _terrain : Terrain, _stats : Character, _keys : Keyset) -> void:
	pass
