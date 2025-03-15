extends Control

signal start()
signal levels()
signal char_select()

func start_button():
	start.emit()

func on_levels():
	levels.emit()
	
func on_charselect():
	char_select.emit()
