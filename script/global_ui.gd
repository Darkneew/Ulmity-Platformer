extends CanvasLayer

signal home()

var high_score: float = 100
var minutes: int = 0

func start(_high_score: float):
	high_score = _high_score
	$Timer.start()

func go_home():
	home.emit()

func _process(_delta):
	var minutes_prefix = ""
	if minutes < 10:
		minutes_prefix += "0"
	var seconds_prefix = ""
	if $Timer.time_left > 50:
		seconds_prefix += "0"
	$TimerLabel.text = minutes_prefix + str(minutes) + ":" + seconds_prefix + str(floorf( 60 - $Timer.time_left))
	$ToHighScore.value = min(100, (minutes * 60 + 60 - $Timer.time_left) / high_score * 100)

func _on_timer_timeout():
	minutes += 1
