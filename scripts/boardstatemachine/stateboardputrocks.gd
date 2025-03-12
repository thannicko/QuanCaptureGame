class_name StateBoardPutRocks extends State

func entry() -> void:
	print("Entered: ", name, " with selected first: ", statemachine.first_dropoff_square)
	determine_selected_direction()
	for square_node in statemachine.board.squares:
		var square = square_node as Square
		square.square_clicked.connect(on_square_clicked.bind(square))

func determine_selected_direction() -> void:
	var diff = statemachine.selected_square.position.x - statemachine.first_dropoff_square.position.x
	if (diff > 0):
		statemachine.put_direction = BoardStateMachine.PutRocksDirection.Left
	else:
		statemachine.put_direction = BoardStateMachine.PutRocksDirection.Left
	print("Put rocks direction: ", statemachine.put_direction)
		

func drop_off_first_rock() -> void:
	pass
		
func on_square_clicked(square: Square) -> void:
	print("Square clicekd: ", square.name)

func exit() -> void:
	for square_node in statemachine.board.squares:
		var square = square_node as Square
		square.square_clicked.disconnect(on_square_clicked)
