class_name Board extends Node2D

const NumberOfSquares : int  = 12
const NumberOfPlayerSquares : int  = 5
const SquareSize: Vector2 = Vector2(16, 16)
const SquareScene : PackedScene = preload("res://scenes/square.tscn")
const BigSquareScene : PackedScene = preload("res://scenes/squarebig.tscn")
var squares: Array[Square]

func _ready() -> void:
	_spawn_board()

func _spawn_board():
	squares.clear()
	for child in get_children().filter(func(child): return child is Square):
		child.queue_free()
	_spawn_big_square(false)
	_spawn_row(0, false)
	_spawn_big_square(true)
	_spawn_row(1, true)

func _spawn_big_square(is_last_square: bool) -> void:
	var big_square = BigSquareScene.instantiate() as BigSquare
	big_square.name = "BigSquare"
	if (is_last_square):
		big_square.name = "LastBigSquare"
	add_child(big_square)
	squares.append(big_square)
	if (is_last_square):
		big_square.position.x = (NumberOfPlayerSquares + 1) * SquareSize.x * big_square.scale.x
		big_square.face_left()
	else:
		big_square.face_right()

func _spawn_row(row_index : int, backward: bool) -> void:
	for i in NumberOfPlayerSquares:
		var square = SquareScene.instantiate() as Square
		if backward:
			square.position.x = (NumberOfPlayerSquares - i) * SquareSize.x * square.scale.x
		else:
			square.position.x = (i + 1) * SquareSize.x * square.scale.x
		square.position.y = row_index * SquareSize.y * square.scale.y
		square.name = "Square" + str(i) + "Row" + str(row_index)
		add_child(square)
		squares.append(square)
