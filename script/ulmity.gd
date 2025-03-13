extends Node

var rng = RandomNumberGenerator.new()
const MENU = preload("res://scenes/menu.tscn")
const LEVEL = preload("res://scenes/level.tscn")
const TRANSITION = preload("res://scenes/transition.tscn")
const TAQUIN = preload("res://scenes/taquin.tscn")

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

func load_menu():
	get_tree().paused = false
	remove_child.call_deferred(get_child(1))
	var my_menu = MENU.instantiate()
	add_child(my_menu)
	my_menu.start.connect(load_level.bind(0))

func transition(text, callback, sub="", time = 5):
	get_tree().paused = false
	remove_child.call_deferred(get_child(1))
	var my_scene = TRANSITION.instantiate()
	my_scene.init(text, sub) 
	add_child(my_scene)
	get_tree().create_timer(time).timeout.connect(callback)

func end_taquin(iswin, scene, callback):
	if iswin:
		transition("Well player", back_to_scene.bind(scene, callback.bind(iswin)), "", 3)
	else:
		transition("Try again another time", back_to_scene.bind(scene, callback.bind(iswin)), "", 2)

func back_to_scene(scene, callback = null):
	get_tree().paused = false
	remove_child.call_deferred(get_child(1))
	add_child(scene)
	callback.call()

func play_taquin(callback):
	# the callback should take one argument, wether the game was won or not 
	get_tree().paused = false
	var scene = get_child(1)
	remove_child.call_deferred(scene)
	var my_taq = TAQUIN.instantiate()
	add_child(my_taq)
	my_taq.win.connect(end_taquin.bind(scene, callback))

func read_high_score(level):
	var json = JSON.new()
	var file = FileAccess.open("res://high_scores.json", FileAccess.READ)
	var text = file.get_as_text()
	if text.length() == 0:
		init_high_score()
		file.close()
		return read_high_score(level)
	var error = json.parse(text)
	if error == OK:
		var data_received = json.data
		if typeof(data_received) == TYPE_ARRAY:
			file.close()
			return data_received[level]
		else:
			print("JSON error: wrong data format")
			init_high_score()
			file.close()
			return read_high_score(level)
	else:
		print("JSON Parse Error: ", json.get_error_message())
		init_high_score()
		file.close()
		return read_high_score(level)

func init_high_score():
	print("Resetting the data")
	var file = FileAccess.open("res://high_scores.json", FileAccess.WRITE)
	var high_scores = Array() 
	for i in range(levels.size()):
		high_scores.append(10e10)
	file.store_string(JSON.stringify(high_scores))
	file.close()

func write_high_score(score, level):
	var json = JSON.new()
	var file = FileAccess.open("res://high_scores.json", FileAccess.READ_WRITE)
	var text = file.get_as_text()
	if text.length() == 0:
		init_high_score()
		file.close()
		return write_high_score(score, level)
	var error = json.parse(text)
	if not error:
		var data_received = json.data
		if typeof(data_received) == TYPE_ARRAY and data_received.size() > 0:
			data_received[level] = score 
			file.store_string(JSON.stringify(data_received))
			file.close()
		else:
			print("JSON error: wrong data format")
			init_high_score()
			file.close()
			return write_high_score(score, level)
	else:
		print("JSON Parse Error: ", json.get_error_message())
		init_high_score()
		file.close()
		return write_high_score(score, level)

func next_level(phs, s, i):
	var time = 5
	var text = ""
	var sub = ""
	if s < phs:
		time = 10
		text += "Amazing!"
		sub += "Previous high score:  " + str(floorf(phs*100)/100) + "s\nNew high score:  " + str(floorf(s*100)/100) + "s"
	else:
		text += "Nice try!"
		sub += "High score:  " + str(floorf(phs*100)/100) + "s\nYour score:  " + str(floorf(s*100)/100) + "s"
	transition(text, load_level.bind(i), sub, time)

func load_level(i: int):
	get_tree().paused = false
	if i >= levels.size():
		load_menu()
	else: 
		remove_child.call_deferred(get_child(1))
		var our_level = LEVEL.instantiate()
		add_child(our_level)
		var hs = read_high_score(i)
		our_level.start_level(levels[i], preload("res://ressources/characters/char1.tres"), preload("res://ressources/characters/default.tres"), hs)
		our_level.next_level.connect(next_level.bind(i+1))
		our_level.change_high_score.connect(write_high_score.bind(i))
		our_level.home.connect(load_menu)
		our_level.taquin.connect(play_taquin)
