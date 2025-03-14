extends State

func init_state(player : CharacterController, _terrain : Terrain, _stats : Character) -> void:
	player.sprite.play("falling")
	player.animation_player.play("death")
	player.get_tree().create_timer(player.animation_player.current_animation_length).timeout.connect(restart.bind(player))
	

func process(_delta, _player : CharacterController, _terrain : Terrain, _stats : Character):
	pass 

func restart(player):
	player.init(player.init_pos, player.init_terrain)
