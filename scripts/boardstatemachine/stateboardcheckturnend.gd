class_name StateBoardCheckTurnEnd extends State

func entry() -> void:
	print("Entered: check turn end")
	var has_not_eaten = statemachine.previous_state.name != "StateBoardEatSquare"
	var next_square : Square = statemachine.get_next_square(
		statemachine.last_dropoff_square)
	var square_after_next : Square = statemachine.get_next_square(
		next_square)
	if (next_square.rock_pile.rocks_count() > 0 and has_not_eaten):
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
			statemachine.board.turn_started.connect(on_turn_started)
			statemachine.board.turn_ended.emit()
	
func on_turn_started(player_index : int) -> void:
	statemachine.allowed_row_index = player_index
	statemachine.change_to_state("StateBoardPickupRocks")

func exit() -> void:
	if (statemachine.board.turn_started.is_connected(on_turn_started)):
		statemachine.board.turn_started.disconnect(on_turn_started)
