extends Node

const UI: PackedScene = preload("res://scenes/ui.tscn")
const CHARACTER: PackedScene = preload("res://scenes/character.tscn")
const STAR: PackedScene = preload("res://scenes/star.tscn")

signal next_level(previous_score, score)
signal home()
signal change_high_score(score: float)
signal taquin(callback)

var high_score: float

func go_home():
	home.emit()

func play_taquin(callback):
	taquin.emit(callback)

func win(ui1, ui2):
	$Control.stop_time()
	ui1.win()
	ui2.win()
	get_tree().paused = true
	if $Control.get_time() < high_score:
		change_high_score.emit($Control.get_time())
	get_tree().create_timer(1).timeout.connect(change_level)
	
func change_level():
	get_tree().paused = false
	next_level.emit(high_score, $Control.get_time())

func start_level(level: PackedScene, player1: Character, player2: Character, hs: float):
	high_score = hs
	$Control.start(hs)
	
	# Wold preparation
	var world : Level = level.instantiate()
	world.process_mode = Node.PROCESS_MODE_PAUSABLE
	var ui1 = UI.instantiate()
	var ui2 = UI.instantiate()
	ui1.restart_key = player1.restart_key
	ui1.pause_key = player1.pause_key
	ui2.restart_key = player2.restart_key
	ui2.pause_key = player2.pause_key
	%Viewport1.add_child(world)
	%Viewport1.add_child(ui1)
	%Viewport2.world_2d = %Viewport1.world_2d
	%Viewport2.add_child(ui2)
	var star = STAR.instantiate()
	world.add_child(star)
	star.position = world.goal.position
	star.end_game.connect(win.bind(ui1, ui2))
	world.taquin.connect(play_taquin)
	
	# Player 1 creation
	var p1: CharacterController = CHARACTER.instantiate()
	p1.stats = player1
	p1.init(world.player1_position.position, world.starting_terrain)
	world.add_child(p1)
	p1.ui = ui1
	var rc = RemoteTransform2D.new()
	rc.remote_path = %Viewport1/Camera1.get_path()
	p1.add_child(rc)
	ui1._restart = p1.init.bind(world.player1_position.position, world.starting_terrain)
	
	# Player 2 creation
	var p2: CharacterController = CHARACTER.instantiate()
	p2.stats = player2
	p2.init(world.player2_position.position, world.starting_terrain)
	world.add_child(p2)
	p2.ui = ui2
	var _rc = RemoteTransform2D.new()
	_rc.remote_path = %Viewport2/Camera2.get_path()
	p2.add_child(_rc)
	ui2._restart = p2.init.bind(world.player2_position.position, world.starting_terrain)
