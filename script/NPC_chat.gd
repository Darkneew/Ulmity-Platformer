extends Node2D

@export var text_holder: RichTextLabel
@export var dialogue_zone: Area2D
@export var dialogue: Array[MessageUnit]

var message_unit: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	dialogue_zone.body_entered.connect(enterZone)
	dialogue_zone.body_exited.connect(exitZone)

func enterZone(player):
	text_holder.visible = true 
	display_unit(player, message_unit)

func exitZone(player):
	text_holder.visible = false
	player.ui.reset_button()

func display_unit(player, unit):
	player.score = player.score + dialogue[unit].score
	player.ui.reset_button()
	text_holder.text = dialogue[unit].text
	for answer in dialogue[unit].answers:
		player.ui.add_button(answer.text, display_unit.bind(player, answer.ref))
