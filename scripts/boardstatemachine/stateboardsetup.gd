class_name StateBoardSetup extends State

func entry() -> void:
	print("Entered: ", name)
	for square_node in statemachine.board.squares:
		var square = square_node as Square
		square.set_process_input(false)
		if (square is BigSquare):
			square.rock_pile.set_big_rocks(statemachine.NumberOfStartingRocksBigSquare)
		else:
			square.rock_pile.set_rocks(statemachine.NumberOfStartingRocks)
	#TODO: Determine the first player here
	statemachine.change_to_state("StateBoardPickupRocks")



func exit() -> void:
	pass
