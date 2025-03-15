extends Control

signal home
signal load_level(i:int)

func _on_button_load_level(i: int):
	load_level.emit(i)
	
func _on_button_home():
	home.emit()
