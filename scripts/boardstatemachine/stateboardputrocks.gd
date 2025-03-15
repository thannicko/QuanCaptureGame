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
	for i in statemachine.selected_square.rock_pile.rocks_count():
		var next_square = statemachine.get_next_square(starting_square)
		next_square.enable()
		_square_path.append(next_square)
		starting_square = next_square
	
	for square in statemachine.board.squares:
		if square not in _square_path:
			square.disable()
	
func on_square_clicked(square: Square) -> void:
	if square == _square_path.front():
		_drop_rock_at(square)

func _check_path_empty() -> void:
	if _square_path.is_empty():
		statemachine.change_to_state("StateBoardCheckTurnEnd")

func _drop_rock_at(destination: Square) -> void:
	if (statemachine.selected_square.rock_pile.rocks_count() > 0):
		var rock = statemachine.selected_square.rock_pile.pop_front()
		destination.rock_pile.add_rock(rock)
		_square_path.erase(destination)
		statemachine.last_dropoff_square = destination
		_check_path_empty()

func exit() -> void:
	for square_node in statemachine.board.squares:
		var square = square_node as Square
		square.square_clicked.disconnect(on_square_clicked)
