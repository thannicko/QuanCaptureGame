class_name StateBoardPutRocks extends State

var _square_path: Array[Square] = []

func entry() -> void:
	print("Entered: ", name, " with selected first: ", statemachine.first_dropoff_square)
	_determine_selected_direction()
	_disable_unreachable_squares()
	_drop_rock_at(statemachine.first_dropoff_square as Square)
	for square_node in statemachine.board.squares:
		var square = square_node as Square
		square.square_clicked.connect(on_square_clicked.bind(square))

func _determine_selected_direction() -> void:
	var diff = statemachine.selected_square.position.x - statemachine.first_dropoff_square.position.x
	if (diff > 0):
		statemachine.put_direction = BoardStateMachine.PutRocksDirection.Left
	else:
		statemachine.put_direction = BoardStateMachine.PutRocksDirection.Right
	print("Put rocks direction: ", statemachine.put_direction)

func _disable_unreachable_squares() -> void:
	var reachable_indices: Array[int]  = []
	var selected_index = statemachine.board.squares.find(statemachine.selected_square)
	for i in statemachine.selected_square.rock_pile.rocks_count():
		var indice = 0
		if (statemachine.put_direction == BoardStateMachine.PutRocksDirection.Left):
			indice = (selected_index + i + 1) % statemachine.board.squares.size()
		else:
			indice = (selected_index - i - 1) % statemachine.board.squares.size()
		reachable_indices.append(indice)
		_square_path.append(statemachine.board.squares[indice])
	for i in statemachine.board.squares.size():
		if i not in reachable_indices:
			statemachine.board.squares[i].disable()
	
func on_square_clicked(square: Square) -> void:
	if square == _square_path.front():
		_drop_rock_at(square)

func _drop_rock_at(destination: Square) -> void:
	if (statemachine.selected_square.rock_pile.rocks_count() > 0):
		var rock = statemachine.selected_square.rock_pile.pop_front()
		destination.rock_pile.add_rock(rock)
		destination.disable()
		_square_path.erase(destination)
		print("Rock dropped, path: ", _square_path)

func exit() -> void:
	for square_node in statemachine.board.squares:
		var square = square_node as Square
		square.square_clicked.disconnect(on_square_clicked)
