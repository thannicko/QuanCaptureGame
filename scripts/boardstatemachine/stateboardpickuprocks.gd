class_name StateBoardPickupRocks extends State

func entry() -> void:
	print("Entered: ", name)
	for square_node in statemachine.board.squares:
		var square = square_node as Square
		square.square_clicked.connect(on_square_clicked.bind(square))
		square.enable()
		
func on_square_clicked(square: Square) -> void:
	if (statemachine.selected_square == null):
		if (not square.rock_pile.is_empty()):
			square.rock_pile.pick_up()
			statemachine.selected_square = square
		else:
			print("Square empty!")
	else:
		if (square == statemachine.selected_square):
			square.rock_pile.put_down()
			statemachine.selected_square = null
		elif (abs(square.position.x - statemachine.selected_square.position.x) == square.get_size().x):
			statemachine.first_dropoff_square = square
			statemachine.change_to_state("StateBoardPutRocks")
		else:
			print("Too far away")

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
	for i in statemachine.board.squares.size():
		if i not in reachable_indices:
			statemachine.board.squares[i].disable()

func _determine_selected_direction() -> void:
	statemachine.put_direction = statemachine.determine_direction(
		statemachine.selected_square, # from
		statemachine.first_dropoff_square # to
	)

func exit() -> void:
	_determine_selected_direction()
	for square_node in statemachine.board.squares:
		var square = square_node as Square
		square.square_clicked.disconnect(on_square_clicked)
