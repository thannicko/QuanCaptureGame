class_name BoardStateMachine extends StateMachine

@export var board: Board

enum PutRocksDirection { Left, Right }

var selected_square: Square
var first_dropoff_square: Square
var last_dropoff_square: Square
var empty_square_to_tap: Square
var eaten_square: Square
var put_direction: PutRocksDirection

const NumberOfStartingRocks : int = 5

func toggle_put_direction() -> void:
	put_direction = get_toggled_direction(put_direction)

func get_toggled_direction(input: PutRocksDirection) -> PutRocksDirection:
	if (input == PutRocksDirection.Left):
		return BoardStateMachine.PutRocksDirection.Right
	else:
		return BoardStateMachine.PutRocksDirection.Left

func get_next_square(square: Square, direction: PutRocksDirection) -> Square:
	if (direction == PutRocksDirection.Left):
		return get_left_square_from(square)
	return get_right_square_from(square)

func get_right_square_from(square: Square) -> Square:
	var index = board.squares.find(square)
	if (index < board.squares.size() / 2):
		# First row
		var next_index =  (index + 1) % board.squares.size()
		return board.squares[next_index]
	else:
		# Second row
		var next_index = (index - 1) % board.squares.size()
		return board.squares[next_index]

func get_left_square_from(square: Square) -> Square:
	var index = board.squares.find(square)
	if (index < board.squares.size() / 2):
		# First row
		var next_index =  (index - 1) % board.squares.size()
		return board.squares[next_index]
	else:
		# Second row
		var next_index = (index + 1) % board.squares.size()
		return board.squares[next_index]

func determine_direction(from : Square, to: Square) -> PutRocksDirection:
	var diff = from.position.x - to.position.x
	if (diff > 0):
		return BoardStateMachine.PutRocksDirection.Left
	else:
		return BoardStateMachine.PutRocksDirection.Right
