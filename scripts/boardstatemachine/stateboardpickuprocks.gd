class_name StateBoardPickupRocks extends State

var allowed_squares: Array[Square]
var board: Board

func entry() -> void:
	print("Entered: ", name)
	statemachine.selected_square = null
	statemachine.first_dropoff_square = null
	board = statemachine.board
	allowed_squares = board.get_all_squares_in_row(
		statemachine.allowed_row_index)
	if (is_all_squares_empty()):
		print("All squares empty, refilling")
		refill_squares()
	for square_node in board.squares:
		var square = square_node as Square
		square.square_clicked.connect(on_square_clicked.bind(square))
		square.enable()

func is_all_squares_empty() -> bool:
	for square in allowed_squares:
		print(square, " is empty: ", square.is_empty())
		if not square.is_empty():
			return false
	return true

func refill_squares() -> void:
	for square in allowed_squares:
		square.rock_pile.put_down()
		square.rock_pile.set_rocks(1)
	board.borrowed_from_stash.emit(
		statemachine.allowed_row_index,
		board.NumberOfPlayerSquares)
		
func on_square_clicked(square: Square) -> void:
	if statemachine.paused:
		return
	if (statemachine.selected_square == null):
		if (square is BigSquare):
			GlobalPrompter.prompt("Picking up the big square is not allowed!")
		elif (not allowed_squares.has(square)):
			GlobalPrompter.prompt("Only allowed to pick up from your own squares!")
		elif (not square.rock_pile.is_empty()):
			statemachine.board.picked_up_rock.emit()
			square.rock_pile.pick_up()
			statemachine.selected_square = square
		else:
			GlobalPrompter.prompt("Square empty!")
	else:
		if (square == statemachine.selected_square):
			square.rock_pile.put_down()
			statemachine.selected_square = null
		elif (abs(square.position.x - statemachine.selected_square.position.x) <= statemachine.selected_square.get_size().x):
			print("First dropoff square: ", square.name)
			statemachine.first_dropoff_square = square
			_determine_selected_direction()
			statemachine.change_to_state("StateBoardPutRocks")
		else:
			GlobalPrompter.prompt("Rock should be dropped to adjacent squares!")

func _determine_selected_direction() -> void:
	statemachine.put_direction = statemachine.determine_direction(
		statemachine.selected_square, # from
		statemachine.first_dropoff_square # to
	)

func exit() -> void:
	print("Exiting: selected square, ", statemachine.selected_square)
	for square_node in board.squares:
		var square = square_node as Square
		square.square_clicked.disconnect(on_square_clicked)
