extends Control

signal load_level(level: int)
signal home

var next_level: int

func init(_text, _sub, next_num: int, last: bool):
	if last:
		$Next.visible = false
	$Text.text = _text
	$Subtext.text = _sub
	next_level = next_num

func go_to_level(diff: int):
	load_level.emit(next_level + diff)

func go_home():
	home.emit()
