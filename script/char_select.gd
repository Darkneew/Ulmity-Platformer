extends Control

signal home
signal change_char1(c: Character)
signal change_char2(c: Character)

const chars := [preload("res://ressources/characters/default.tres"), preload("res://ressources/characters/shade.tres"), preload("res://ressources/characters/ben.tres"), preload("res://ressources/characters/flash.tres"), preload("res://ressources/characters/giant.tres"), preload("res://ressources/characters/alien.tres"), preload("res://ressources/characters/superman.tres")]

var c1 : int = 0 
var c2 : int = 0

func set_appearance_p1(_char: Character):
	$P1/Image.scale = Vector2(_char.width, _char.height)
	$P1/Image.modulate = _char.color
	$P1/RichTextLabel.text = "[center]" + _char.name + "\n" + _char.description + "\nAbility: " + _char.ability_name + "[/center]"

func set_appearance_p2(_char: Character):
	$P2/Image.scale = Vector2(_char.width, _char.height)
	$P2/Image.modulate = _char.color
	$P2/RichTextLabel.text = "[center]" + _char.name + "\n" + _char.description + "\nAbility: " + _char.ability_name + "[/center]"

func init(char1, char2):
	set_appearance_p1(char1)
	set_appearance_p2(char2)
	$P2/AnimationPlayer.play("RESET")
	$P1/AnimationPlayer.play("RESET")
	

func _on_button_home():
	home.emit()

func change_p1_left():
	c1 -= 1
	if c1 < 0:
		c1 += chars.size()
	change_char1.emit(chars[c1])
	$P1/AnimationPlayer.play("p1-out")

func change_p1_right():
	c1 += 1
	if c1 >= chars.size():
		c1 -= chars.size()
	change_char1.emit(chars[c1])
	$P1/AnimationPlayer.play("p1-out")

func on_end_animation_p1(anim):
	if not anim == "p1-out":
		return
	$P1/AnimationPlayer.queue("p1-in")
	set_appearance_p1(chars[c1])

func change_p2_left():
	c2 -= 1
	if c2 < 0:
		c2 += chars.size()
	change_char2.emit(chars[c2])
	$P2/AnimationPlayer.play("p2-out")

func change_p2_right():
	c2 += 1
	if c2 >= chars.size():
		c2 -= chars.size()
	change_char2.emit(chars[c2])
	$P2/AnimationPlayer.play("p2-out")

func on_end_animation_p2(anim):
	if not anim == "p2-out":
		return
	$P2/AnimationPlayer.queue("p2-in")
	set_appearance_p2(chars[c2])
