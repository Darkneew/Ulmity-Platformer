extends Node

var rng = RandomNumberGenerator.new()
const MENU = preload("res://scenes/menu.tscn")
const LEVEL = preload("res://scenes/level.tscn")

const levels = [
	preload("res://levels/level1.tscn"), 
	preload("res://levels/level2.tscn"), 
	preload("res://levels/level3.tscn")
]

const musics = [
	preload("res://sound/music_1.mp3"),
	preload("res://sound/music_2.mp3"),
	preload("res://sound/music_3.mp3"),	
	preload("res://sound/music_4.mp3"),
]

func change_music():
	await get_tree().create_timer(rng.randf_range(3, 10)).timeout
	$AudioStreamPlayer.stream = musics[rng.randi_range(0, musics.size() - 1)]
	$AudioStreamPlayer.play()

func load_level(i: int):
	remove_child.call_deferred(get_child(1))
	if i >= levels.size():
		var my_menu = MENU.instantiate()
		add_child(my_menu)
		my_menu.start.connect(load_level.bind(1))
	else: 
		var our_level = LEVEL.instantiate()
		add_child(our_level)
		our_level.start_level(levels[i], preload("res://ressources/characters/char1.tres"), preload("res://ressources/characters/default.tres"))
		our_level.next_level.connect(load_level.bind(i+1))
