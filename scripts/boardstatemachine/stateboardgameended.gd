class_name StateBoardGameEnded extends State

var board: Board

func entry() -> void:
	print("Enter: ", name)
	GlobalPrompter.prompt("Game ended!")
	board = statemachine.board
	board.game_ended.emit()
	eat_all_remaining_squares_for_row(0)
	eat_all_remaining_squares_for_row(1)
	for square in board.squares:
		square.disable()

func eat_all_remaining_squares_for_row(row_index: int) -> void:
	for square in board.get_all_squares_in_row(row_index):
		if not square.is_empty():
			board.square_eaten.emit(row_index, square)
