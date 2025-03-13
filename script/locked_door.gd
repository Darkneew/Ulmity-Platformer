extends StaticBody2D

signal taquin(callback)

var switch := false

func on_player_enter(_body):
	if switch:
		switch = false 
		return
	switch = true 
	taquin.emit(open)

func open(isopen: bool):
	if isopen:
		self.queue_free()
