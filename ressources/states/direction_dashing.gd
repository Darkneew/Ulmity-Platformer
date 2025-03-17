extends State

const DIST = 800
const TIME = 0.3

func init_state(player : CharacterController, _terrain : Terrain, _stats : Character) -> void:
	player.sprite.play("floating")
	var prev_vel = player.velocity
	player.velocity = player.velocity.normalized() * DIST / TIME
	player.get_tree().create_timer(TIME).timeout.connect(end_dash.bind(player, prev_vel))

func process(_delta, player : CharacterController, _terrain : Terrain, _stats : Character, _keys : Keyset):
	player.move_and_slide()

func end_dash(player, prev_vel):
	player.velocity = prev_vel
	player.update_state(player.states.floating_state)
