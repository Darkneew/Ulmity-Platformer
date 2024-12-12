extends Node

var rng = RandomNumberGenerator.new()
var menu = preload("res://scenes/menu.tscn")

var levels = [
	preload("res://levels/level1.tscn"), 
	preload("res://levels/level2.tscn"), 
	preload("res://levels/level3.tscn")
]

var musics = [
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
		var my_menu = menu.instantiate()
		add_child(my_menu)
		my_menu.start.connect(load_level.bind(1))
	else: 
		var our_level = levels[i].instantiate()
		add_child(our_level)
		our_level.next_level.connect(load_level.bind(i+1))
