class_name StateBoardPickupRocks extends State

func entry() -> void:
	print("Entered: ", name)
	statemachine.selected_square = null
	statemachine.first_dropoff_square = null
	for square_node in statemachine.board.squares:
		var square = square_node as Square
		square.square_clicked.connect(on_square_clicked.bind(square))
		square.enable()
		
func on_square_clicked(square: Square) -> void:
	if (statemachine.selected_square == null):
		if (square is BigSquare):
			print("Only allowed to pick up player squares!")
		elif (statemachine.board.get_row_index(square) != statemachine.allowed_row_index):
			print("Only allowed to pick up from your own squares!")
		elif (not square.rock_pile.is_empty()):
			square.rock_pile.pick_up()
			statemachine.selected_square = square
		else:
			print("Square empty!")
	else:
		if (square == statemachine.selected_square):
			square.rock_pile.put_down()
			statemachine.selected_square = null
		elif (abs(square.position.x - statemachine.selected_square.position.x) == square.get_size().x):
			print("First dropoff square: ", square.name)
			statemachine.first_dropoff_square = square
			_determine_selected_direction()
			statemachine.change_to_state("StateBoardPutRocks")
		else:
			print("Too far away")

func _determine_selected_direction() -> void:
	statemachine.put_direction = statemachine.determine_direction(
		statemachine.selected_square, # from
		statemachine.first_dropoff_square # to
	)

func exit() -> void:
	print("Exiting: selected square, ", statemachine.selected_square)
	for square_node in statemachine.board.squares:
		var square = square_node as Square
		square.square_clicked.disconnect(on_square_clicked)
