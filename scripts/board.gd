class_name Board extends Node2D

signal square_eaten(player_index: int, square: Square)
signal turn_started(player_index: int)
signal turn_ended()
signal game_ended()
signal borrowed_from_stash(player_index: int, amount: int)

const NumberOfSquares : int  = 12
const NumberOfPlayerSquares : int  = 5
const SquareSize: Vector2 = Vector2(16, 16)
const SquareScene : PackedScene = preload("res://scenes/square.tscn")
const BigSquareScene : PackedScene = preload("res://scenes/squarebig.tscn")
var squares: Array[Square]

func _ready() -> void:
	_spawn_board()
	
func start_turn(player_index : int) -> void:
	print("Start turn wiht index: ", player_index)
	turn_started.emit(player_index)

func get_row_index(square: Square) -> int:
	var index = squares.find(square)
	if (index >= 1 and index <= NumberOfPlayerSquares):
		return 0
	elif (index > NumberOfPlayerSquares + 1 and index < NumberOfSquares):
		return 1
	return -1

func get_all_squares_in_row(row_index: int) -> Array[Square]:
	var result : Array[Square] = []
	for i in range(0, NumberOfSquares):
		if (get_row_index(squares[i]) == row_index):
			result.append(squares[i])
	return result

func _spawn_board():
	squares.clear()
	for child in get_children().filter(func(child): return child is Square):
		child.queue_free()
	_spawn_big_square(false)
	_spawn_row(0, false)
	_spawn_big_square(true)
	_spawn_row(1, true) # Spawn backwards so we have increasing index clockwise
	_assign_neighbors_to_square()

func _assign_neighbors_to_square() -> void:
	squares[0].anticlockwise_neighbor = squares.back()
	squares[0].clockwise_neighbor = squares[1]
	for i in range(1, NumberOfSquares - 1):
		squares[i].anticlockwise_neighbor = squares[i - 1]
		squares[i].clockwise_neighbor = squares[i + 1]
	squares[NumberOfSquares - 1].anticlockwise_neighbor = squares[NumberOfSquares - 2]
	squares[NumberOfSquares - 1].clockwise_neighbor = squares[0]

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
