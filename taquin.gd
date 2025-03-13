extends Control

signal win(iswin: bool)

@onready var sliding_timer: Timer = $SlidingTimer
@onready var rectangles: Array[TextureRect] = [$Board/Rect1, $Board/Rect2, $Board/Rect3, $Board/Rect4, $Board/Rect5, $Board/Rect6, $Board/Rect7, $Board/Rect8]
var board: = [[-1,1,2], [3,4,5], [6,7,0]]
const REF = [[-1,1,2], [3,4,5], [6,7,0]]
var is_moving : TextureRect = null 
var moving_from: Vector2
var moving_to: Vector2

func _ready():
	for i in range(500):
		var rect = randi_range(0, 7)
		move(rect, true)

func find_coordinates_of_rectangle(rectangle) -> Vector2:
	var x = null
	var y = null
	for i in range(3): 
		for j in range(3): 
			if board[i][j] == rectangle:
				x = i 
				y = j
	return Vector2(x,y)

func move(rectangle, fast = false): 
	rectangles[rectangle].get_child(0).release_focus()
	if not is_moving == null :
		return 
	var rect_coordinates = find_coordinates_of_rectangle(rectangle)
	var empty_coordinates = find_coordinates_of_rectangle(-1)
	if not rect_coordinates.distance_squared_to(empty_coordinates) == 1:
		return false  # means that we cannot move
	if fast:
		rectangles[rectangle].position = 200*Vector2(empty_coordinates.y, empty_coordinates.x)
	else:
		is_moving = rectangles[rectangle]
		sliding_timer.start()
		moving_from = rectangles[rectangle].position
		moving_to = 200*Vector2(empty_coordinates.y, empty_coordinates.x)
	board[rect_coordinates.x][rect_coordinates.y] = -1
	board[empty_coordinates.x][empty_coordinates.y] = rectangle
	return true 


func _on_sliding_timer_timeout():
	is_moving.position = moving_to
	var iswin = true 
	for i in range(3): 
		for j in range(3): 
			if not board[i][j] == REF[i][j]:
				iswin = false 
				break
	if iswin:
		win.emit(true)
		return
	is_moving = null

func _process(_delta):
	if is_moving == null:
		return 
	is_moving.position = lerp(moving_to, moving_from, sliding_timer.time_left / sliding_timer.wait_time)


func _on_home_pressed():
	win.emit(false)
