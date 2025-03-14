class_name StateBoardPickupRocks extends State

func entry() -> void:
	print("Entered: ", name)
	statemachine.selected_square = null
	statemachine.first_dropoff_square = null
	for square_node in statemachine.board.squares:
		var square = square_node as Square
		square.square_clicked.connect(on_square_clicked.bind(square))
		square.enable()

func check_all_squares_empty() -> void:
	#TODO: Add take 5 of own stash if empty.
	pass
		
func on_square_clicked(square: Square) -> void:
	if (statemachine.selected_square == null):
		if (square is BigSquare):
			GlobalPrompter.prompt("Picking up the big square is not allowed!")
		elif (statemachine.board.get_row_index(square) != statemachine.allowed_row_index):
			GlobalPrompter.prompt("Only allowed to pick up from your own squares!")
		elif (not square.rock_pile.is_empty()):
			square.rock_pile.pick_up()
			statemachine.selected_square = square
		else:
			GlobalPrompter.prompt("Square empty!")
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
			GlobalPrompter.prompt("Rock should be dropped to adjacent squares!")

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
