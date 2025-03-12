class_name StateBoardPutRocks extends State

func entry() -> void:
	print("Entered: ", name, " with selected first: ", statemachine.first_dropoff_square)
	determine_selected_direction()
	_drop_rock_at(statemachine.first_dropoff_square as Square)
	for square_node in statemachine.board.squares:
		var square = square_node as Square
		square.square_clicked.connect(on_square_clicked.bind(square))

func determine_selected_direction() -> void:
	var diff = statemachine.selected_square.position.x - statemachine.first_dropoff_square.position.x
	if (diff > 0):
		statemachine.put_direction = BoardStateMachine.PutRocksDirection.Left
	else:
		statemachine.put_direction = BoardStateMachine.PutRocksDirection.Right
	print("Put rocks direction: ", statemachine.put_direction)

		
func on_square_clicked(square: Square) -> void:
	_drop_rock_at(square)

func _drop_rock_at(destination: Square) -> void:
	if (statemachine.selected_square.rock_pile.rocks_count() > 0):
		destination.rock_pile.add_rock(1)
		statemachine.selected_square.rock_pile.remove_rock(1)
		destination.disable()
		

func exit() -> void:
	for square_node in statemachine.board.squares:
		var square = square_node as Square
		square.square_clicked.disconnect(on_square_clicked)
