extends Node

const UI: PackedScene = preload("res://scenes/ui.tscn")
const CHARACTER: PackedScene = preload("res://scenes/character.tscn")
const STAR: PackedScene = preload("res://scenes/star.tscn")

signal next_level()

func win(ui1, ui2):
	ui1.win()
	ui2.win()
	get_tree().paused = true
	get_tree().create_timer(3).timeout.connect(change_level)
	
func change_level():
	get_tree().paused = false
	next_level.emit()

func heart_update(nb: int, ui: Node):
	ui.update_hearts(nb)

func start_level(level: PackedScene, player1: Character, player2: Character):
	
	# Wold preparation
	var world : Level = level.instantiate()
	world.process_mode = Node.PROCESS_MODE_PAUSABLE
	var ui1 = UI.instantiate()
	var ui2 = UI.instantiate()
	%Viewport1.add_child(world)
	%Viewport1.add_child(ui1)
	%Viewport2.world_2d = %Viewport1.world_2d
	%Viewport2.add_child(ui2)
	var star = STAR.instantiate()
	world.add_child(star)
	star.position = world.goal.position
	star.end_game.connect(win.bind(ui1, ui2))
	
	# Player 1 creation
	var p1: CharacterController = CHARACTER.instantiate()
	p1.stats = player1
	p1.init(world.player1_position.position, world.starting_terrain)
	world.add_child(p1)
	p1.heart_update.connect(heart_update.bind(ui1))
	var rc = RemoteTransform2D.new()
	rc.remote_path = %Viewport1/Camera1.get_path()
	p1.add_child(rc)
	ui1._restart = p1.init.bind(world.player1_position.position, world.starting_terrain)
	
	# Player 2 creation
	var p2: CharacterController = CHARACTER.instantiate()
	p2.stats = player2
	p2.init(world.player2_position.position, world.starting_terrain)
	world.add_child(p2)
	p2.heart_update.connect(heart_update.bind(ui2))
	var _rc = RemoteTransform2D.new()
	_rc.remote_path = %Viewport2/Camera2.get_path()
	p2.add_child(_rc)
	ui2._restart = p2.init.bind(world.player2_position.position, world.starting_terrain)
