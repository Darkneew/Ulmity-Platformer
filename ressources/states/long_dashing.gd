extends State

const DIST = 2000
const TIME = 0.5

func init_state(player : CharacterController, terrain : Terrain, _stats : Character) -> void:
	player.sprite.play("floating")
	var sign = 1 
	if player.sprite.flip_h :
		sign = -1
	player.velocity = terrain.gravity_direction.rotated(-PI/2) * DIST / TIME * sign
	player.get_tree().create_timer(TIME).timeout.connect(end_dash.bind(player))

func process(_delta, player : CharacterController, _terrain : Terrain, _stats : Character, _keys : Keyset):
	player.move_and_slide()

func end_dash(player):
	player.update_state(player.states.floating_state)
