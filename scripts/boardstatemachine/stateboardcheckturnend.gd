class_name StateBoardCheckTurnEnd extends State

func entry() -> void:
	print("Entered: check turn end")
	if (is_game_ended()):
		statemachine.change_to_state("StateBoardGameEnded")
	else:
		continue_game()

func continue_game() -> void:
	var is_eating_square = statemachine.previous_state.name == "StateBoardEatSquare"
	var next_square : Square = statemachine.get_next_square(
		statemachine.last_dropoff_square)
	var square_after_next : Square = statemachine.get_next_square(
		next_square)
	if next_square.is_empty() and square_after_next.is_empty():
		end_turn()
	elif next_square is BigSquare and not next_square.is_empty():
		end_turn()
	elif next_square is Square and not next_square.is_empty() and not is_eating_square:
		statemachine.board.can_continue_with_rocks.emit()
		next_square.rock_pile.pick_up()
		statemachine.selected_square = next_square
		statemachine.first_dropoff_square = square_after_next
		statemachine.change_to_state("StateBoardPutRocks")
	elif next_square.is_empty() and not square_after_next.is_empty():
		statemachine.board.can_eat_square.emit()
		statemachine.eaten_square = square_after_next
		statemachine.empty_square_to_tap = next_square
		statemachine.change_to_state("StateBoardEatSquare")
	else:
		end_turn()

func end_turn() -> void:
	statemachine.board.turn_started.connect(on_turn_started)
	statemachine.board.turn_ended.emit()

func is_game_ended() -> bool:
	var board: Board = statemachine.board
	var first_big_square = board.squares[0]
	var last_big_square = board.squares[board.NumberOfPlayerSquares + 1]
	return first_big_square.is_empty() and last_big_square.is_empty()
	
func on_turn_started(player_index : int) -> void:
	statemachine.allowed_row_index = player_index
	statemachine.change_to_state("StateBoardPickupRocks")

func exit() -> void:
	if (statemachine.board.turn_started.is_connected(on_turn_started)):
		statemachine.board.turn_started.disconnect(on_turn_started)
