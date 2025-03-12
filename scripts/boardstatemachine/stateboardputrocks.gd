class_name StateBoardPutRocks extends State

var _square_path: Array[Square] = []

func entry() -> void:
	print("Entered: ", name, " with selected first: ", statemachine.first_dropoff_square)
	_disable_unreachable_squares()
	for square_node in statemachine.board.squares:
		var square = square_node as Square
		square.square_clicked.connect(on_square_clicked.bind(square))
	if (statemachine.previous_state.name == "StateBoardPickupRocks"):
		_drop_rock_at(statemachine.first_dropoff_square as Square)

func _disable_unreachable_squares() -> void:
	_square_path.clear()
	var starting_square: Square = statemachine.selected_square
	var temp_direction = statemachine.put_direction
	for i in statemachine.selected_square.rock_pile.rocks_count():
		var next_square = statemachine.get_next_square(starting_square, temp_direction)
		next_square.enable()
		_square_path.append(next_square)
		starting_square = next_square
		if (next_square is BigSquare):
			temp_direction = statemachine.get_toggled_direction(temp_direction)
	
	for square in statemachine.board.squares:
		if square not in _square_path:
			square.disable()
	
func on_square_clicked(square: Square) -> void:
	if square == _square_path.front():
		_drop_rock_at(square)
	if _square_path.is_empty():
		statemachine.last_dropoff_square = square
		statemachine.change_to_state("StateBoardCheckTurnEnd")

func _drop_rock_at(destination: Square) -> void:
	if (statemachine.selected_square.rock_pile.rocks_count() > 0):
		var rock = statemachine.selected_square.rock_pile.pop_front()
		destination.rock_pile.add_rock(rock)
		destination.disable()
		_square_path.erase(destination)
		print("Rock dropped, path: ", _square_path)
	if (destination is BigSquare):
		statemachine.toggle_put_direction()
		print("Toggled direction, now is: ", statemachine.put_direction)

func exit() -> void:
	for square_node in statemachine.board.squares:
		var square = square_node as Square
		square.square_clicked.disconnect(on_square_clicked)
