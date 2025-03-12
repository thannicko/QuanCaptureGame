class_name StateBoardCheckTurnEnd extends State

func entry() -> void:
	var next_square : Square = statemachine.get_next_square(
		statemachine.last_dropoff_square, statemachine.put_direction)
	var square_after_next : Square = statemachine.get_next_square(
		next_square, statemachine.put_direction)
	if (next_square.rock_pile.rocks_count() > 0):
		next_square.rock_pile.pick_up()
		statemachine.selected_square = next_square
		statemachine.first_dropoff_square = square_after_next
		statemachine.change_to_state("StateBoardPutRocks")
	else:
		if (next_square.is_empty() and not square_after_next.is_empty()):
			statemachine.eaten_square = square_after_next
			statemachine.empty_square_to_tap = next_square
			statemachine.change_to_state("StateBoardEatSquare")
		else:
			print("End turn")

func exit() -> void:
	pass
