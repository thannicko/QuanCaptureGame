class_name BoardStateMachine extends StateMachine

@export var board: Board

enum PutRocksDirection { Clockwise, Anticlockwise }

var paused: bool
var allowed_row_index: int
var selected_square: Square
var first_dropoff_square: Square
var last_dropoff_square: Square
var empty_square_to_tap: Square
var eaten_square: Square
var put_direction: PutRocksDirection

const NumberOfStartingRocksBigSquare : int = 1
const NumberOfStartingRocks : int = 5

func _ready() -> void:
	super._ready()
	board.paused.connect(on_board_paused)
	
func on_board_paused(is_paused: bool) -> void:
	paused = is_paused
	

func get_next_square(target: Square) -> Square:
	var next_square = target.anticlockwise_neighbor
	if (put_direction == BoardStateMachine.PutRocksDirection.Clockwise):
		next_square = target.clockwise_neighbor
	return next_square

func determine_direction(from : Square, to: Square) -> PutRocksDirection:
	var diff = from.position.x - to.position.x
	var is_square_on_second_row = board.squares.find(from) > board.NumberOfPlayerSquares
	is_square_on_second_row = is_square_on_second_row or board.squares.find(from) == 0
	if (is_square_on_second_row):
		diff *= -1; # Second row flips around left/right
	if (diff > 0):
		return BoardStateMachine.PutRocksDirection.Anticlockwise
	else:
		return BoardStateMachine.PutRocksDirection.Clockwise
