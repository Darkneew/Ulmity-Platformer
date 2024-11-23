extends Node

var menu = preload("res://scenes/menu.tscn")

var levels = [
	preload("res://levels/level1.tscn"), 
	preload("res://levels/level2.tscn"), 
	preload("res://levels/level3.tscn")
]

func load_level(i: int):
	remove_child.call_deferred(get_child(0))
	if i > levels.size():
		var my_menu = menu.instantiate()
		add_child(my_menu)
		menu.start.connect(load_level.bind(1))
	else: 
		var our_level = levels[i-1].instantiate()
		add_child(our_level)
		our_level.next_level.connect(load_level.bind(i+1))
