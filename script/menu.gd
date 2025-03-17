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

func _ready():
	$AnimationPlayer.play("RESET")
	
func keys_open():
	$AnimationPlayer.play("keys_slide_in")

func keys_close():
	$AnimationPlayer.play("keys_slide_out")
