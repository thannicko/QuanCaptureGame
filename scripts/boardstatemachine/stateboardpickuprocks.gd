class_name StateBoardPickupRocks extends State

func entry() -> void:
	print("Entered: ", name)
	for square_node in statemachine.board.squares:
		var square = square_node as Square
		square.square_clicked.connect(on_square_clicked.bind(square))
		square.set_process_input(true)
		
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
		else:
			statemachine.first_dropoff_square = square
			statemachine.change_to_state("StateBoardPutRocks")

func exit() -> void:
	for square_node in statemachine.board.squares:
		var square = square_node as Square
		square.square_clicked.disconnect(on_square_clicked)
